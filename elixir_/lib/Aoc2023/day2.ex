defmodule Aoc2023.Day2 do
  alias Common.Input

  defmodule Pull do
    defstruct red: 0, green: 0, blue: 0
  end

  @red_limit 12
  @green_limit 13
  @blue_limit 14

  def part1() do
    games =
      Input.parse()
      |> Enum.map(&parse_game/1)
      |> Map.new()

    games
    |> Enum.filter(fn {_id, pulls} ->
      Enum.all?(pulls, fn
        %{red: red, green: green, blue: blue}
        when red <= @red_limit and green <= @green_limit and blue <= @blue_limit ->
          true

        _default ->
          false
      end)
    end)
    |> Enum.map(fn {id, _} -> id end)
    |> Enum.sum()
  end

  defp parse_game("Game " <> game) do
    {id, rest} = Integer.parse(game)
    <<": ">> <> pulls = rest

    pulls =
      pulls
      |> String.trim()
      |> String.split(";")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&pase_pull/1)

    {id, pulls}
  end

  defp pase_pull(pull) do
    result =
      pull
      |> String.split(",", trim: true)
      |> Enum.map(&String.trim/1)
      |> Enum.map(&parse_pull_color/1)

    struct(Pull, result)
  end

  defp parse_pull_color(result) do
    case Integer.parse(result) do
      {num, " red"} -> {:red, num}
      {num, " green"} -> {:green, num}
      {num, " blue"} -> {:blue, num}
    end
  end
end
