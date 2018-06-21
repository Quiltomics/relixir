defmodule RelixirTest do
  use ExUnit.Case
  doctest Relixir

  test "single function call" do
    assert Relixir.runR("cat('hello')") == "hello"
    assert Relixir.runR("cat('sailing across\nthe oceans\n')") == """
sailing across
the oceans
"""
  end

  test "exporting variable" do
    x = Relixir.runR("x <- (5+3)", "x")
    y = Relixir.runR("y <- (2*4)", "y")
    assert x == y
  end

  @tag :tentative
  test "multiline R code" do
    rCode =  """
    a = 0
    for (i in 1:10) {
      a = a +i
    }
    a
    """
    assert Relixir.runR(rCode) == 55
  end

  @tag :tentative
  test "datafile input" do
  rCode = """
  x = read.csv("some_url")
  summary(x)
  """
  end

  @tag :tentative
  test "piping" do
    Relixir.runR("matrix(1:10,nrow=2)")
    |> Relixir.callRFunc("svd")
  end

end
