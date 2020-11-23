defmodule Title.OptsTest do
  use ExUnit.Case, async: true

  test "opts get initialized to default value" do
    assert Title.Opts.new([]) == %Title.Opts{style: :ap, custom: []}
  end

  test "opts get initialized to correct style" do
    opts = Title.Opts.new(style: :ny_times)
    assert opts.style == :ny_times
  end

  test "opts ignore invalid style" do
    opts = Title.Opts.new(style: :timmo)
    assert opts.style == :ap
  end

  test "opts get initialized with custom words" do
    opts = Title.Opts.new(custom: ["hello", "goodbye"])
    assert opts.custom == ["hello", "goodbye"]
  end

  test "opts ignore invalid custom" do
    opts = Title.Opts.new(custom: "hello")
    assert opts.custom == []
  end
end
