defmodule Y2024.Day1 do
  def part1 do
    inputs = parse()
    {first, second} = Enum.unzip(inputs)

    Enum.zip([Enum.sort(first), Enum.sort(second)])
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def part2 do
    inputs = parse()
    {first, second} = Enum.unzip(inputs)

    frequencies = Enum.frequencies(second)

    first
    |> Enum.map(fn n ->
      n * Map.get(frequencies, n, 0)
    end)
    |> Enum.sum()
  end

  defp parse do
    {:ok, input} = File.read(".input.txt")

    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
  end
end
