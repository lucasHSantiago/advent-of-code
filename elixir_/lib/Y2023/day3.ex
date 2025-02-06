defmodule Y2023.Day3 do
  alias Common.Input

  def part1() do
    lines = Input.parse() |> Enum.with_index()
    symbol_positions = symbols_position(lines)

    nums_position(lines)
    |> Stream.filter(fn {row_span, col_span, _n} ->
      for i <- row_span,
          j <- col_span,
          reduce: false,
          do: (acc -> acc || {i, j} in symbol_positions)
    end)
    |> Stream.map(&elem(&1, 2))
    |> Enum.sum()
  end

  def part2() do
    lines = Input.parse() |> Enum.with_index()
    nums = nums_position(lines)

    lines
    |> Stream.flat_map(fn {line, i} ->
      Regex.scan(~r/\*/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {j, _} -> {i, j} end)
    end)
    |> Stream.map(fn {i, j} ->
      case Enum.filter(nums, fn {row_span, col_span, _n} -> i in row_span and j in col_span end) do
        [a, b] -> elem(a, 2) * elem(b, 2)
        _ -> 0
      end
    end)
    |> Enum.sum()
  end

  defp nums_position(lines) do
    lines
    |> Enum.flat_map(fn {line, i} ->
      Regex.scan(~r/\d+/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {j, len} ->
        {(i - 1)..(i + 1)//1, (j - 1)..(j + len)//1,
         String.to_integer(String.slice(line, j, len))}
      end)
    end)
  end

  defp symbols_position(lines) do
    lines
    |> Stream.flat_map(fn {line, i} ->
      Regex.scan(~r/[^a-zA-Z0-9\.]/, line, return: :index)
      |> List.flatten()
      |> Enum.map(fn {j, _} -> {i, j} end)
    end)
    |> MapSet.new()
  end
end
