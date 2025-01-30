defmodule Aoc2021.Day2 do
  alias Common.Input, as: Input

  def part1 do
    Input.parse()
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [k, v] -> [k, String.to_integer(v)] end)
    |> Enum.reduce(%{}, fn [k, v], acc ->
      case k do
        "forward" -> Map.update(acc, k, v, fn forward -> forward + v end)
        "down" -> Map.update(acc, k, v, fn down -> down + v end)
        "up" -> Map.update(acc, k, v, fn up -> up + v end)
      end
    end)
    |> then(fn %{{"forward", forward}, {"down", down}, {"up", up}} -> forward * abs(down - up) end)
  end

  def part2 do
    Input.parse()
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [k, v] -> [k, String.to_integer(v)] end)
    |> Enum.reduce({_position = 0, _aim = 0, _depth = 0}, fn
      ["forward", number], {position, aim, depth} ->
        {position + number, aim, depth + aim * number}

      ["down", number], {position, aim, depth} ->
        {position, aim + number, depth}

      ["up", number], {position, aim, depth} ->
        {position, aim - number, depth}
    end)
    |> then(fn {position, _aim, depth} -> depth * position end)
  end
end
