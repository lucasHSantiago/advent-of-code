defmodule Aoc2024.Day3 do
  def part1 do
    input = parse()
    scan_part1(input)
  end

  def part2 do
    parse()
    |> Enum.map(fn input ->
      scan(input, 0, :disabled)
    end)
    |> Enum.sum()
  end

  def part2_veryfy do
    parse()
    |> Enum.map(fn input ->
      part2(input)
    end)
    |> Enum.sum()
  end

  def part2(input) do
    ~r/(mul)\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)/
    |> Regex.scan(input)
    |> Enum.reduce({0, true}, fn
      ["do()"], {acc, _} ->
        {acc, true}

      ["don't()"], {acc, _} ->
        {acc, false}

      [_, "mul", one, two], {acc, do?} ->
        if do? do
          {acc + String.to_integer(one) * String.to_integer(two), true}
        else
          {acc, false}
        end
    end)
    |> elem(0)
  end

  def scan(input, acc, :enabled) do
    case Regex.split(~r/don't\(\)/, input, parts: 2) do
      [valid, rest] -> scan(rest, acc + process(valid), :disabled)
      [valid] -> acc + process(valid)
    end
  end

  def scan(input, acc, :disabled) do
    case Regex.split(~r/do\(\)/, input, parts: 2) do
      [_, rest] -> scan(rest, acc, :enabled)
      [_] -> acc
    end
  end

  defp process(valid) do
    regex = ~r/mul\((\d{1,3}),(\d{1,3})\)/

    Regex.scan(regex, valid, capture: :all_but_first)
    |> Enum.reduce(0, fn [a, b], acc ->
      acc + String.to_integer(a) * String.to_integer(b)
    end)
    |> dbg()
  end

  def scan_part1(input) do
    regex = ~r/mul\((\d{1,3}),(\d{1,3})\)/

    [result] =
      Enum.map(input, fn input ->
        Regex.scan(regex, input, capture: :all_but_first)
        |> Enum.reduce(0, fn [a, b], acc ->
          acc + String.to_integer(a) * String.to_integer(b)
        end)
      end)

    result
  end

  def parse do
    {:ok, input} = File.read("input.txt")
    String.trim(input)
      |> String.split("\n", trim: true)
  end
end
