defmodule RelixirTest do
  use ExUnit.Case
  doctest Relixir

  test "greets the world" do
    assert Relixir.hello() == :world
  end
end
