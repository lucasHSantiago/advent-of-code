defmodule Common.Input do
  def parse() do
    {:ok, input} = File.read("input.txt")

    input
    |> String.split("\n", trim: true)
  end
end
