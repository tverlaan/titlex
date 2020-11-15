# Title

[![Hex.pm Version](https://img.shields.io/hexpm/v/titlex.svg?style=flat)](https://hex.pm/packages/titlex)

<!-- MDOC !-->

`Title` is a library that aims at capitalizing your titles in a simplified manner. There are a couple
of different styles, but they don't differ much. If you do have a preference check out the available
styles in `Title.Opts`.

You can easily pass in some of your own _custom_ words. These are words for which you have your
own custom casing. This can also be used to extend the library with abbreviations since they're not
(yet?) part of this library. Same goes for names, though many names fall under the default category
to be capitalized.

## Examples

```elixir
iex> Title.capitalize("`Title` is a library that aims at capitalizing your titles in a simplified manner")
"`Title` Is a Library That Aims at Capitalizing Your Titles in a Simplified Manner"

iex> Title.capitalize("You can easily pass in some of your own 'custom' words", custom: ["CUSTOM"])
"You Can Easily Pass in Some of Your Own 'CUSTOM' Words"

iex> Title.capitalize("The default style has *underneath* capitalized")
"The Default Style Has *Underneath* Capitalized"

iex> Title.capitalize("The chicago style has *underneath* NOT capitalized", style: :chicago)
"The Chicago Style Has *underneath* Not Capitalized"

iex> Title.capitalized?("Is My Title Properly Capitalized?")
true
```

<!-- MDOC !-->

## Installation

The package can be installed by adding `titlex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:titlex, "~> 0.1.0"}
  ]
end
```

Documentation can be found at [https://hexdocs.pm/titlex](https://hexdocs.pm/titlex).

## Credits

  * [https://github.com/vercel/title/](https://github.com/vercel/title/)
  * [https://capitalizemytitle.com/](https://capitalizemytitle.com/)

