defmodule Title.Opts do
  @moduledoc """
  Defines the options used for capitalization. There are two options to alter the strategy:

    - `:style` - The capitalization style you want for your title. This library supports the
      following styles: `:ap`, `:chicago`, `:ny_times`, `:wikipedia`. The default is `:ap`.
    - `:custom` - A list of words for which you have determined your own casing style. The matching
      will happen on the lowercased version.
  """

  defstruct [:style, :custom]

  @type t() :: %__MODULE__{style: atom(), custom: [String.t()]}

  @doc false
  def new(opts) do
    style = style_from_opts(opts)
    custom = custom_from_opts(opts)

    %__MODULE__{style: style, custom: custom}
  end

  defp style_from_opts(opts) do
    opts
    |> Keyword.get(:style)
    |> verify_or_default(&(&1 in [:ap, :chicago, :ny_times, :wikipedia]), :ap)
  end

  defp custom_from_opts(opts) do
    opts
    |> Keyword.get(:custom)
    |> verify_or_default(&is_list/1, [])
  end

  defp verify_or_default(opt, fun, default) do
    if fun.(opt) do
      opt
    else
      default
    end
  end
end
