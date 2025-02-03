defmodule Y2023.Day1 do
  alias Common.Input, as: Input

  def part1 do
    input =
      Input.parse()
      |> Enum.map(&(&1 |> String.to_charlist()))

    only_number =
      for word <- input do
        Enum.filter(word, fn c ->
          c >= ?0 && c <= ?9
        end)
      end

    Enum.map(only_number, fn number ->
      [first(number), last(number)]
      |> List.to_integer()
    end)
    |> Enum.sum()
  end

  def last([last]), do: last
  def last([_head | tail]), do: last(tail)
  def first([head | _tail]), do: head

  def part2 do
    list_number =
      Input.parse()
      |> Enum.map(fn line ->
        extract_numbers(line)
        |> Enum.map(fn number ->
          case Integer.parse(number) do
            {val, _} -> val
            :error -> word_to_number(number)
          end
        end)
      end)

    list_number
    |> Enum.map(fn numbers ->
      first(numbers) * 10 + last(numbers)
    end)
    |> Enum.sum()
  end

  def extract_numbers(string) do
    regex = ~r/(?=(one|two|three|four|five|six|seven|eight|nine|[1-9]))/
    Regex.scan(regex, string, capture: :all_but_first)
    |> List.flatten()
  end

  def word_to_number("one"), do: 1
  def word_to_number("two"), do: 2
  def word_to_number("three"), do: 3
  def word_to_number("four"), do: 4
  def word_to_number("five"), do: 5
  def word_to_number("six"), do: 6
  def word_to_number("seven"), do: 7
  def word_to_number("eight"), do: 8
  def word_to_number("nine"), do: 9
  def word_to_number(word), do: word
end
