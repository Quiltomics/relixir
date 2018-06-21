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
  Execute a chunk of R code via little r command
  """
  def runR(rCode, export \\ "")
  def runR(rCode, export) when (is_binary(rCode) and (export == "")) do
    script = """
    x <- (#{rCode})
    cat(serialize(connection=stdout(), object=x))
    """
    port = Port.open({:spawn_executable, littlerExec()},
                     [{:args, ["-e",script]},
                     :stream, :binary, :exit_status, :hide, :use_stdio, :stderr_to_stdout])
    return_data(port)
  end

  def runR(rCode, export) when (is_binary(rCode) and is_binary(export)) do
    script = """
    #{rCode}
    cat(serialize(connection=stdout(), object=#{export}))
    """
    port = Port.open({:spawn_executable, littlerExec()},
                     [{:args, ["-e",script]},
                     :stream, :binary, :exit_status, :hide, :use_stdio, :stderr_to_stdout])
    return_data(port)
  end

  # TODO
  def callRFunc(rCode, args) when is_binary(rCode) do
    port = Port.open({:spawn_executable, littlerExec()},
                     [{:args, ["-e", "cat(serialize(connection=stdout(), object=" <> rCode <> "))"]},
                     :stream, :binary, :exit_status, :hide, :use_stdio, :stderr_to_stdout])
    return_data(port)
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
