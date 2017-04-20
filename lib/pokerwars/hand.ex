defmodule Pokerwars.Hand do
  alias Pokerwars.Card

  def score(cards) do
    cards
    |> order
    |> evaluate
  end

  defp order(cards) do
    Enum.sort(cards, fn(a, b) -> a.rank < b.rank end)
  end

  defp evaluate([%{rank: a}, %{rank: b}, %{rank: c}, %{rank: d}, %{rank: e}] = cards) when b == a + 1 and c == b + 1 and d == c + 1 and e == d + 1 do
    evaluate_straight(cards)
  end

  defp evaluate([%{rank: a}, %{rank: a}, %{rank: a}, %{rank: a}, %{rank: _}]), do: :four_of_a_kind
  defp evaluate([%{rank: _}, %{rank: a}, %{rank: a}, %{rank: a}, %{rank: a}]), do: :four_of_a_kind

  defp evaluate([%{rank: a}, %{rank: a}, %{rank: a}, %{rank: b}, %{rank: b}]), do: :full_house
  defp evaluate([%{rank: b}, %{rank: b}, %{rank: a}, %{rank: a}, %{rank: a}]), do: :full_house

  defp evaluate([%{suit: a}, %{suit: a}, %{suit: a}, %{suit: a}, %{suit: a}]), do: :flush

  defp evaluate([%{rank: a}, %{rank: a}, %{rank: a}, %{rank: _}, %{rank: _}]), do: :three_of_a_kind
  defp evaluate([%{rank: _}, %{rank: a}, %{rank: a}, %{rank: a}, %{rank: _}]), do: :three_of_a_kind
  defp evaluate([%{rank: _}, %{rank: _}, %{rank: a}, %{rank: a}, %{rank: a}]), do: :three_of_a_kind

  defp evaluate([%{rank: a}, %{rank: a}, %{rank: b}, %{rank: b}, %{rank: _}]), do: :two_pairs
  defp evaluate([%{rank: a}, %{rank: a}, %{rank: _}, %{rank: b}, %{rank: b}]), do: :two_pairs
  defp evaluate([%{rank: _}, %{rank: a}, %{rank: a}, %{rank: b}, %{rank: b}]), do: :two_pairs

  defp evaluate([%{rank: a}, %{rank: a}, %{rank: _}, %{rank: _}, %{rank: _}]), do: :pair
  defp evaluate([%{rank: _}, %{rank: a}, %{rank: a}, %{rank: _}, %{rank: _}]), do: :pair
  defp evaluate([%{rank: _}, %{rank: _}, %{rank: a}, %{rank: a}, %{rank: _}]), do: :pair
  defp evaluate([%{rank: _}, %{rank: _}, %{rank: _}, %{rank: a}, %{rank: a}]), do: :pair

  defp evaluate(_), do: :high_card


  defp evaluate_straight([%{suit: a}, %{suit: a}, %{suit: a}, %{suit: a}, %{suit: a, rank: 14}]) do
    :royal_flush
  end

  defp evaluate_straight([%{suit: a}, %{suit: a}, %{suit: a}, %{suit: a}, %{suit: a}]) do
    :straight_flush
  end

  defp evaluate_straight(_) do
    :straight
  end

end
