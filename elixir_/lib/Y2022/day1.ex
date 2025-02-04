defmodule Y2022.Day1 do
  alias Common.Input

  def part1() do
    elve_calories()
    |> Enum.max()
  end

  def part2() do
    elve_calories()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp elve_calories() do
    Input.parse("\n\n")
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn elve_calories ->
      Enum.map(elve_calories, fn calorie ->
        String.to_integer(calorie)
      end)
      |> Enum.sum()
    end)
  end
end
