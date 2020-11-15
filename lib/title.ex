defmodule Title do
  @external_resource "README.md"
  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  alias Title.{Opts, Word}

  @doc """
  Capitalize a title

      iex> Title.capitalize("please capitalize this for me")
      "Please Capitalize This for Me"

  """
  @spec capitalize(String.t(), keyword()) :: String.t()
  def capitalize(title, opts \\ []) do
    opts = Opts.new(opts)

    title
    |> String.split(~r/[\s-]/, include_captures: true)
    |> Word.titelize(opts)
    |> Enum.join()
  end

  @doc """
  Returns a boolean confirming if the given string is capitalized according to the title-style.

      iex> Title.capitalized?("Is Your Title Capitalized?")
      true

      iex> Title.capitalized?("Is your title capitalized?")
      false

  """
  @spec capitalized?(String.t(), keyword()) :: boolean()
  def capitalized?(title, opts \\ []) do
    title == capitalize(title, opts)
  end
end
