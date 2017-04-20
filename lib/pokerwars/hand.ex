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

  defp evaluate([%{rank: a}, %{rank: a}, %{rank: a}, %{rank: a}, %{rank: _}]), do: {:four_of_a_kind, a}
  defp evaluate([%{rank: _}, %{rank: a}, %{rank: a}, %{rank: a}, %{rank: a}]), do: {:four_of_a_kind, a}

  defp evaluate([%{rank: a}, %{rank: a}, %{rank: a}, %{rank: b}, %{rank: b}]), do: {:full_house, {a, b}}
  defp evaluate([%{rank: b}, %{rank: b}, %{rank: a}, %{rank: a}, %{rank: a}]), do: {:full_house, {a, b}}

  defp evaluate([%{suit: a, rank: r1}, %{suit: a, rank: r2}, %{suit: a, rank: r3}, %{suit: a, rank: r4}, %{suit: a, rank: r5}]), do: {:flush, {r5, r4, r3, r2, r1}}

  defp evaluate([%{rank: t}, %{rank: t}, %{rank: t}, %{rank: _}, %{rank: _}]), do: {:three_of_a_kind, t}
  defp evaluate([%{rank: _}, %{rank: t}, %{rank: t}, %{rank: t}, %{rank: _}]), do: {:three_of_a_kind, t}
  defp evaluate([%{rank: _}, %{rank: _}, %{rank: t}, %{rank: t}, %{rank: t}]), do: {:three_of_a_kind, t}

  defp evaluate([%{rank: p1}, %{rank: p1}, %{rank: p2}, %{rank: p2}, %{rank: r1}]), do: {:two_pairs, {p2, p1, r1}}
  defp evaluate([%{rank: p1}, %{rank: p1}, %{rank: r1}, %{rank: p2}, %{rank: p2}]), do: {:two_pairs, {p2, p1, r1}}
  defp evaluate([%{rank: r1}, %{rank: p1}, %{rank: p1}, %{rank: p2}, %{rank: p2}]), do: {:two_pairs, {p2, p1, r1}}

  defp evaluate([%{rank: p}, %{rank: p}, %{rank: r1}, %{rank: r2}, %{rank: r3}]), do: {:pair, {p, r3, r2, r1}}
  defp evaluate([%{rank: r1}, %{rank: p}, %{rank: p}, %{rank: r2}, %{rank: r3}]), do: {:pair, {p, r3, r2, r1}}
  defp evaluate([%{rank: r1}, %{rank: r2}, %{rank: p}, %{rank: p}, %{rank: r3}]), do: {:pair, {p, r3, r2, r1}}
  defp evaluate([%{rank: r1}, %{rank: r2}, %{rank: r3}, %{rank: p}, %{rank: p}]), do: {:pair, {p, r3, r2, r1}}

  defp evaluate([%{rank: r1}, %{rank: r2}, %{rank: r3}, %{rank: r4}, %{rank: r5}]), do: {:high_card, {r5, r4, r3, r2, r1}}


  defp evaluate_straight([%{suit: a}, %{suit: a}, %{suit: a}, %{suit: a}, %{suit: a, rank: 14}]) do
    {:royal_flush, {}}
  end

  defp evaluate_straight([%{suit: a}, %{suit: a}, %{suit: a}, %{suit: a}, %{suit: a, rank: r}]) do
    {:straight_flush, r}
  end

  defp evaluate_straight([%{rank: _}, %{rank: _}, %{rank: _}, %{rank: _}, %{rank: r}]) do
    {:straight, r}
  end

end
