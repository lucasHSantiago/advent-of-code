defmodule Y2024.Day2 do
  def part1 do
    parse()
    |> Enum.count(fn levels ->
      is_safe(levels)
    end)
  end

  def part2 do
    parse()
    |> Enum.count(fn levels ->
      damp(levels, [])
    end)
  end

  defp damp([level | levels], prefix) do
    is_safe(Enum.reverse(prefix, levels)) or damp(levels, [level | prefix])
  end

  defp damp([], prefix) do
    is_safe(prefix)
  end

  defp is_safe([a, a | _]), do: false

  defp is_safe([a, b | _] = levels) do
    diff = a - b
    is_safe(levels, div(diff, abs(diff)))
  end

  defp is_safe(levels, sign) do
    Enum.chunk_every(levels, 2, 1)
    |> Enum.all?(fn chunks ->
      case chunks do
        [a, b] -> (sign * (a - b)) in 1..3
        [_] -> true
      end
    end)
  end

  defp parse do
    {:ok, input} = File.read("input.txt")

    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      String.split(line, " ", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
  end
end
