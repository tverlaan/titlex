defmodule Title.Word do
  @moduledoc false

  @articles [
    "a",
    "an",
    "the"
  ]

  @conjunctions [
    "for",
    "and",
    "nor",
    "but",
    "or",
    "yet",
    "so"
  ]

  @prepositions [
    "aboard",
    "about",
    "above",
    "across",
    "after",
    "against",
    "along",
    "amid",
    "among",
    "anti",
    "around",
    "as",
    "at",
    "before",
    "behind",
    "below",
    "beneath",
    "beside",
    "besides",
    "between",
    "beyond",
    "but",
    "by",
    "concerning",
    "considering",
    "despite",
    "down",
    "during",
    "except",
    "excepting",
    "excluding",
    "following",
    "for",
    "from",
    "in",
    "inside",
    "into",
    "like",
    "minus",
    "near",
    "of",
    "off",
    "on",
    "onto",
    "opposite",
    "over",
    "past",
    "per",
    "plus",
    "regarding",
    "round",
    "save",
    "since",
    "than",
    "through",
    "to",
    "toward",
    "towards",
    "under",
    "underneath",
    "unlike",
    "until",
    "up",
    "upon",
    "versus",
    "via",
    "with",
    "within",
    "without"
  ]

  @styles %{
    ap: @articles ++ @conjunctions ++ Enum.filter(@prepositions, &(String.length(&1) < 4)),
    chicago: @articles ++ @conjunctions ++ @prepositions,
    ny_times: @articles ++ @conjunctions ++ @prepositions,
    wikipedia: @articles ++ @conjunctions ++ Enum.filter(@prepositions, &(String.length(&1) < 5))
  }

  def titelize([first | rest], %Title.Opts{} = opts) do
    [do_capitalize(first, opts, true), titelize_next(rest, opts)]
  end

  defp titelize_next([], _opts), do: []

  defp titelize_next([word | rest], opts) do
    [do_capitalize(word, opts, rest == []), titelize_next(rest, opts)]
  end

  defp do_capitalize(word, _, _) when word in [" ", "-"], do: word

  defp do_capitalize(word, %{style: style, custom: custom}, first_or_last) do
    with %Regex{} = re_word <- compile_re(word),
         :not_custom <- customize(word, re_word, custom),
         :not_downcase <- downcase(word, re_word, style, not first_or_last),
         {start, length} <- alpha_index(word) do
      binary_part(word, 0, start) <>
        String.capitalize(binary_part(word, start, length)) <>
        String.downcase(binary_part(word, start + length, byte_size(word) - start - length))
    else
      word -> word
    end
  end

  defp compile_re(word) do
    ~r/[a-zA-Z]+/
    |> Regex.scan(word)
    |> Enum.join()
    |> case do
      "" -> word
      alpha -> Regex.compile!(alpha, "i")
    end
  end

  defp customize(word, re_word, custom) do
    case Enum.find(custom, &Regex.match?(re_word, &1)) do
      nil -> :not_custom
      custom -> Regex.replace(re_word, word, custom)
    end
  end

  defp downcase(word, re_word, style, downcase?) do
    if downcase? and Enum.any?(@styles[style], &Regex.match?(re_word, &1)) do
      String.downcase(word)
    else
      :not_downcase
    end
  end

  defp alpha_index(word) do
    [[index] | _] = Regex.scan(~r/[a-zA-Z]+/, word, return: :index)
    index
  end
end
