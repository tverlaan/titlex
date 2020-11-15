defmodule TitleTest do
  use ExUnit.Case, async: true
  doctest Title

  describe "title with single word" do
    test "regular word" do
      assert Title.capitalize("hello") == "Hello"
    end

    test "article word" do
      assert Title.capitalize("tHe") == "The"
    end

    test "leading single quote" do
      assert Title.capitalize("'hello") == "'Hello"
    end

    test "trailing question mark" do
      assert Title.capitalize("hello?") == "Hello?"
    end

    test "single quote mid-word" do
      assert Title.capitalize("hel'lo") == "Hel'lo"
    end
  end

  describe "title with two words" do
    test "regular sentence" do
      assert Title.capitalize("hello world") == "Hello World"
    end

    test "single quote on the second word" do
      assert Title.capitalize("hello 'world") == "Hello 'World"
    end

    test "second is article word" do
      assert Title.capitalize("hello thE") == "Hello The"
    end
  end

  describe "title with three words" do
    test "single quote on middle word" do
      assert Title.capitalize("hello 'awesome world") == "Hello 'Awesome World"
    end

    test "single quote on middle article word" do
      assert Title.capitalize("hello 'the world") == "Hello 'the World"
    end
  end

  describe "title with custom word(s)" do
    test "capitalizes a short sentence with a custom word" do
      assert Title.capitalize("hello world", custom: ["WORLD"]) == "Hello WORLD"
    end

    test "capitalizes a short sentence with custom words" do
      assert Title.capitalize("hello world", custom: ["WORLD", "heLlO"]) == "heLlO WORLD"
    end

    test "capitalizes a short sentence with a single quote and a custom word" do
      assert Title.capitalize("hello 'world", custom: ["WORLD"]) == "Hello 'WORLD"
    end

    test "capitalizes a short sentence with a single quote and custom words" do
      assert Title.capitalize("hello' world?", custom: ["WORLD", "heLlO"]) == "heLlO' WORLD?"
    end

    test "capitalizes a medium sentence with a quotes and custom words" do
      assert Title.capitalize("hello' what 'about the world?", custom: ["WORLD", "AbOUt"]) ==
               "Hello' What 'AbOUt the WORLD?"
    end

    test "capitalizes a medium sentence with a quotes and custom words with article" do
      assert Title.capitalize("hello' what 'about the world?", custom: ["THE", "AbOUt"]) ==
               "Hello' What 'AbOUt THE World?"
    end
  end
end
