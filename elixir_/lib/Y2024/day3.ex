defmodule Y2024.Day3 do
  alias Common.Input

  def part1() do
    Input.parse()
    |> Enum.map(fn line ->
      Regex.scan(~r/mul\((\d+),(\d+)\)/, line, capture: :all_but_first)
      |> Enum.map(fn [a, b] ->
        String.to_integer(a) * String.to_integer(b)
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def part2() do
    Input.parse()
    |> Enum.flat_map(&tokenize_with_state/1)
    |> Enum.reduce({true, 0}, fn instruction, {continue?, total} ->
      case {continue?, instruction} do
        {_, "do()"} -> {true, total}
        {_, "don't()"} -> {false, total}
        {true, instruction} -> {true, mul(instruction) + total}
        {false, _} -> {false, total}
      end
    end)
    |> elem(1)
  end

  defp tokenize_with_state(line) do
    ~r/(?>mul\(\d+,\d+\))|(?>do\(\))|(?>don't\(\))/
    |> Regex.scan(line)
    |> List.flatten()
  end

  defp mul(token) do
    token
    |> String.replace("mul(", "")
    |> String.replace(")", "")
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(&(&1 * &2))
  end
end
