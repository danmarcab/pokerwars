defmodule Pokerwars.HandTest do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  test "evaluates royal flush of hearts" do
    cards = [
      %Card{rank: 10, suit: :hearts},
      %Card{rank: 11, suit: :hearts},
      %Card{rank: 12, suit: :hearts},
      %Card{rank: 13, suit: :hearts},
      %Card{rank: 14, suit: :hearts}
    ]

    assert Hand.score(cards) == {:royal_flush, {}}
  end

  test "evaluates royal flush of spades" do
    cards = [
      %Card{rank: 10, suit: :spades},
      %Card{rank: 11, suit: :spades},
      %Card{rank: 12, suit: :spades},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 14, suit: :spades}
    ]

    assert Hand.score(cards) == {:royal_flush, {}}
  end

  test "evaluates straight flush of spades" do
    cards = [
      %Card{rank: 10, suit: :spades},
      %Card{rank: 11, suit: :spades},
      %Card{rank: 12, suit: :spades},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 9, suit: :spades}
    ]

    assert Hand.score(cards) == {:straight_flush, 13}
  end

  test "evaluates flush of spades" do
    cards = [
      %Card{rank: 2, suit: :spades},
      %Card{rank: 11, suit: :spades},
      %Card{rank: 8, suit: :spades},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 9, suit: :spades}
    ]

    assert Hand.score(cards) == {:flush, {13, 11, 9, 8, 2}}
  end

  test "evaluates three of a kind" do
    cards = [
      %Card{rank: 11, suit: :diamonds},
      %Card{rank: 11, suit: :spades},
      %Card{rank: 11, suit: :clubs},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 9, suit: :spades}
    ]

    assert Hand.score(cards) == {:three_of_a_kind, 11}
  end

  test "evaluates two pairs" do
    cards = [
      %Card{rank: 11, suit: :diamonds},
      %Card{rank: 11, suit: :spades},
      %Card{rank: 9, suit: :clubs},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 9, suit: :spades}
    ]

    assert Hand.score(cards) == {:two_pairs, {11, 9, 13}}
  end

  test "evaluates pair" do
    cards = [
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 11, suit: :spades},
      %Card{rank: 9, suit: :clubs},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 9, suit: :spades}
    ]

    assert Hand.score(cards) == {:pair, {9, 13, 11, 10}}
  end

  test "evaluates straight for mismatching suits" do
    cards = [
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 11, suit: :diamonds},
      %Card{rank: 12, suit: :diamonds},
      %Card{rank: 13, suit: :clubs},
      %Card{rank: 14, suit: :clubs}
    ]

    assert Hand.score(cards) == {:straight, 14}
  end

  test "evaluates high card" do
    cards = [
      %Card{rank: 2, suit: :spades},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 11, suit: :spades}
    ]

    assert Hand.score(cards) == {:high_card, {11, 7, 5, 3, 2}}
  end

  test "evaluates poker" do
    cards = [
      %Card{rank: 5, suit: :spades},
      %Card{rank: 5, suit: :hearts},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 5, suit: :clubs}
    ]

    assert Hand.score(cards) == {:four_of_a_kind, 5}
  end

  test "evaluates full house" do
    cards = [
      %Card{rank: 5, suit: :spades},
      %Card{rank: 7, suit: :hearts},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 5, suit: :clubs}
    ]

    assert Hand.score(cards) == {:full_house, {5, 7}}
  end

end
