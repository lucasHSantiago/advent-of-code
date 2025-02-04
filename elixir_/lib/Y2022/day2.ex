defmodule Y2022.Day2 do
  alias Common.Input

  def part1() do
    Input.parse()
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(&parse_game(&1))
    |> Enum.sum()
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
end
