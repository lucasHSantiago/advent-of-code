defmodule Y2022.Day3 do
  alias Common.Input

  def part1() do
    Input.parse()
    |> Enum.map(fn line ->
      parse_equals(line)
    end)
    |> Enum.sum()
  end

  def part2() do
    Input.parse()
    |> Enum.chunk_every(3)
    |> Enum.map(fn sacks ->
      common_chars(sacks)
      |> then(fn [inter] -> String.to_charlist(inter) end)
      |> hd
      |> calc_value()
    end)
    |> Enum.sum()
  end

  defp parse_equals(line) do
    line
    |> String.split_at(div(String.length(line), 2))
    |> then(fn {a, b} -> String.myers_difference(a, b) end)
    |> Keyword.get(:eq, "")
    |> String.to_charlist()
    |> hd()
    |> calc_value()
  end

  defp calc_value(ascii) when ascii <= ?Z, do: ascii - ?A + 27
  defp calc_value(ascii), do: ascii - ?a + 1

  def common_chars([str1, str2, str3]) do
    set1 = str1 |> String.graphemes() |> MapSet.new()
    set2 = str2 |> String.graphemes() |> MapSet.new()
    set3 = str3 |> String.graphemes() |> MapSet.new()

    set1
    |> MapSet.intersection(set2)
    |> MapSet.intersection(set3)
    |> MapSet.to_list()
  end
end
