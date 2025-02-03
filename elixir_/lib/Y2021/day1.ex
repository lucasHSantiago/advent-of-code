defmodule Y2021.Day1 do
  alias Common.Input, as: Input

  def part1() do
    Input.parse()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [a, b], acc ->
      if b > a, do: acc + 1, else: acc
    end)
  end

  def part2 do
    Input.parse()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [a, b], acc ->
      if b > a, do: acc + 1, else: acc
    end)
  end
end
