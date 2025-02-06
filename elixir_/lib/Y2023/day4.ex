defmodule Y2023.Day4 do
  alias Common.Input

  def part1() do
    Input.parse()
    |> Stream.map(&String.split(&1, "|"))
    |> Stream.map(fn [winner, mine] ->
      [String.replace(winner, ~r/(Card \d: )/, "") |> String.trim(), mine |> String.trim()]
    end)
    |> Stream.map(fn [winner, mine] ->
      {
        winner |> String.split(" ", trim: true) |> MapSet.new(),
        mine |> String.split(" ", trim: true) |> MapSet.new()
      }
    end)
    |> Stream.map(fn {winner, mine} ->
      MapSet.intersection(winner, mine)
      |> MapSet.size()
      |> then(fn size -> if size > 0, do: 2 ** (size - 1), else: 0 end)
    end)
    |> Enum.sum()
  end
end
