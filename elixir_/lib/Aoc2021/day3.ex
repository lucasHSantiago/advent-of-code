defmodule Aoc2021.Day3 do
  alias Common.Input, as: Input

  def part1 do
    input =
      Input.parse()
      |> Enum.map(&(&1 |> String.to_charlist() |> List.to_tuple()))

    [sample | _] = input
    number_length = tuple_size(sample)
    half = div(length(input), 2)

    gamma_as_list =
      for pos <- 0..(number_length - 1) do
        zero_count = Enum.count_until(input, &(elem(&1, pos) == ?0), half + 1)
        if zero_count > half, do: ?0, else: ?1
      end

    gamma = List.to_integer(gamma_as_list, 2)
    mask = 2 ** number_length - 1
    epsilon = Bitwise.band(Bitwise.bnot(gamma), mask)
    gamma * epsilon
  end
end
