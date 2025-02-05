defmodule Y2022.Day4 do
  alias Common.Input

  def part1() do
    parse_input()
    |> Enum.map(fn pairs ->
      [p1, p2] = pairs
      range_contains?(p1, p2) || range_contains?(p2, p1)
    end)
    |> Enum.count(& &1)
  end

  def part2() do
    parse_input()
    |> Enum.map(fn pairs ->
      [p1, p2] = pairs
      range_joint?(p1, p2)
    end)
    |> Enum.count(& &1)
  end

  defp parse_input() do
    Input.parse()
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(fn range ->
        range
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)
      end)
    end)
  end

  def range_contains?([a, b], [c, d]) do
    a >= c and b <= d
  end

  def range_joint?([a, b], [c, d]) do
    !Range.disjoint?(a..b, c..d)
  end
end
