defmodule Relixir do

  @moduledoc """
  This package provides a wrapper around the `r` command line `littler` which provides the same functionality as `Rscript`, but a little faster.
  You need to have `littler` on your system in order to use this module.

  You can install `littler` from CRAN
  ```R
  install.packages('littler')
  ```
  """
  @doc """
  Hello world.

  ## Examples

      iex> Relixir.hello
      :world

  """
  def hello do
    :world
  end

  @doc """
  Requires `littler` package
  """
  def runR(rCode) when is_binary(rCode) do
    port = Port.open({:spawn_executable, littlerExec()},
                     [{:args, ["-e", "cat(serialize(connection=stdout(), object=" <> rCode <> "))"]},
                     :stream, :binary, :exit_status, :hide, :use_stdio, :stderr_to_stdout])
    return_data(port)
  end

  @doc """
  Hello world.

  ## Examples

      iex> Rport.hello
      "Hello from Rport!"

  """
  def hello do
    "Hello from Rport!"
  end
  def hello(name) do
    "Hi #{name}!"
  end
  defp littlerExec() do
    String.replace( System.find_executable("R"), "/bin/R", "/library/littler/bin/r")
  end

  defp rscriptExec() do
    System.find_executable("R")
  end
  def script(scriptFile, args) when is_list(args) do
    port = Port.open({:spawn_executable, rscriptExec()}, [{:args, [scriptFile] ++ args}, :stream, :binary, :exit_status, :hide, :use_stdio, :stderr_to_stdout])
    handle_output(port)
  end

  def handle_output(port) do
    receive do
      {^port, {:data, data}} ->
        IO.puts(data)
        handle_output(port)
      {^port, {:exit_status, status}} ->
        status
    end
  end

  defp return_data(port) do
    receive do
      {^port, {:data, data}} ->
        data
      {^port, {:exit_status, status}} ->
        status
    end
  end
end
