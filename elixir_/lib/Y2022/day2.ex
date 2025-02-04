defmodule Y2022.Day2 do
  alias Common.Input

  def part1() do
    parse_input()
    |> Enum.map(&parse_game(&1))
    |> Enum.sum()
  end

  def part2() do
    parse_input()
    |> Enum.map(&parse_game2(&1))
    |> Enum.sum()
  end

  defp parse_input() do
    Input.parse()
    |> Enum.map(&String.split(&1, " ", trim: true))
  end

  defp parse_game([a, b]) do
    player_play = parse_play(b)
    player_winner([parse_play(a), player_play]) + play_point(player_play)
  end

  defp parse_play(play) when play in ["A", "X"], do: :rock
  defp parse_play(play) when play in ["B", "Y"], do: :paper
  defp parse_play(play) when play in ["C", "Z"], do: :scissor

  defp play_point(:rock), do: 1
  defp play_point(:paper), do: 2
  defp play_point(:scissor), do: 3

  defp player_winner([:paper, :rock]), do: 0
  defp player_winner([:rock, :scissor]), do: 0
  defp player_winner([:scissor, :paper]), do: 0
  defp player_winner([a, b]) when a == b, do: 3
  defp player_winner([_a, _b]), do: 6

  defp parse_game2([a, b]) do
    case result = needed_paly(b) do
      0 -> result + play_point(lose_hand(parse_play(a)))
      3 -> result + play_point(parse_play(a))
      6 -> result + play_point(winner_hand(parse_play(a)))
    end
  end

  defp winner_hand(:rock), do: :paper
  defp winner_hand(:paper), do: :scissor
  defp winner_hand(:scissor), do: :rock

  defp lose_hand(:rock), do: :scissor
  defp lose_hand(:paper), do: :rock
  defp lose_hand(:scissor), do: :paper

  defp needed_paly("X"), do: 0
  defp needed_paly("Y"), do: 3
  defp needed_paly("Z"), do: 6
end
