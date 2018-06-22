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

  test "exporting single R variables" do
    x = Relixir.runR("x <- (5+3)", "x")
    y = Relixir.runR("y <- (2*4)", "y")
    assert x == y

    x = Relixir.runR("x <- matrix(1:10,nrow=2)", "x")
    y = Relixir.runR("y <- matrix(1:10,ncol=5)", "y")
    assert x == y
  end

  test "capture errors and exit graciously" do
    # Syntax error
    x = Relixir.runR("x <- c(1:5", "x")
    assert x == :error

    # Argument error
    x = Relixir.runR("x <- log(0, base='e')", "x")
    assert x == :error
  end

  @tag timeout: 3000
  test "convert output to json" do
    x = Relixir.runR("x <- 5+3", "x", %{"output" => "json"})
    assert x == "[8]"

    x = Relixir.runR("x <- c(1:5)", "x", %{"output" => "json"})
    assert x= "[1,2,3,4,5]"
  end

  @tag :tentative
  test "exporting multiple R variables" do
    {x, y} = Relixir.runR("""
x <- c(1:5)
y <- x**2
""")
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
    assert Relixir.runR(rCode, "a") == 55
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
