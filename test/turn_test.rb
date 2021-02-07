require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require 'pry'

class TurnTest < Minitest::Test
  def setup
    @card1 = Card.new(:heart, 'Jack', 11)
    @card2 = Card.new(:heart, '10', 10)
    @card3 = Card.new(:heart, '9', 9)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:heart, '8', 8)
    @card6 = Card.new(:diamond, 'Queen', 12)
    @card7 = Card.new(:heart, '3', 3)
    @card8 = Card.new(:diamond, '2', 2)
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @deck2 = Deck.new([@card3, @card4, @card6, @card7])
    @player1 = Player.new("Megan", @deck1)
    @player2 = Player.new("Aurora", @deck2)
    @turn = Turn.new(@player1, @player2)

    card9 = Card.new(:spade, '3', 3)
    card10 = Card.new(:spade, '6', 6)
    card11 = Card.new(:diamond, '8', 8)
    card12 = Card.new(:club, '3', 3)
    card13 = Card.new(:heart, '7', 7)
    card14 = Card.new(:spade, '8', 8)
    deck3 = Deck.new([card9, card10, card11])
    deck4 = Deck.new([card12, card13, card14])
    player3 = Player.new("John", deck3)
    player4 = Player.new("Doe", deck4)
    @turn2 = Turn.new(player3, player4)
  end

  def test_it_exists
    assert_instance_of Turn, @turn
  end

  def test_turn_type_basic
    assert_equal :basic, @turn.type
  end

  def test_turn_type_war
    @player2.deck.remove_card
    assert_equal :war, @turn.type
  end

  def test_turn_type_MAD
    assert_equal :mutually_assured_destruction, @turn2.type
  end

  def test_player1_wins_basic
    assert_equal "Megan", @turn.winner
  end

  def test_player2_wins_basic
    @player1.deck.remove_card
    @player1.deck.remove_card
    assert_equal "Aurora", @turn.winner
  end

  def test_player1_wins_war
    @player2.deck.remove_card
    assert_equal "Megan", @turn.winner
  end

  def test_player2_wins_war
    @player2.deck.remove_card
    @player2.deck.remove_card
    @player2.deck.remove_card
    @player2.deck.remove_card
    @player2.deck.add_card(@card4)
    @player2.deck.add_card(@card3)
    @player2.deck.add_card(@card6)

    assert_equal "Aurora", @turn.winner
  end

  def test_nobody_wins_MAD
    assert_equal "No Winner", @turn2.winner
  end

  def test_both_players_lose_top_card_for_basic
    assert_equal [@card1, @card3], @turn.pile_cards
  end

  def test_both_players_lose_3_cards_for_war
    @player2.deck.remove_card
    assert_equal [@card1, @card4, @card2, @card6, @card5, @card7], @turn.pile_cards
  end

  def test_each_top_3_cards_removed_but_not_to_spoils_for_MAD
    assert_equal [], @turn2.pile_cards
  end

  def test_player1_wins_spoils_from_basic
    assert_equal [@card2, @card5, @card8, @card1, @card3], @turn.award_spoils
  end

  # def test_player2_wins_spoils_from_basic
  #
  # end
  #
  # def test_player1_wins_spoils_from_war
  #
  # end
  #
  # def test_player2_wins_spoils_from_war
  #
  # end
end
