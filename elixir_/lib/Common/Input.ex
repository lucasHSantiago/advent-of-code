defmodule Common.Input do
  def parse(arg \\ "\n") do
    {:ok, input} = File.read("input.txt")

    input
    |> String.split(arg, trim: true)
  end
end
