require './lib/card'
require './lib/deck'
require './lib/player'

class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    turn_type = {
      :basic => player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0),
      :mutually_assured_destruction => player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) && player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2),
      :war => player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
    }
    turn_type.key(true)
  end

  def winner
    turn_type = {
      :basic => player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0),
      :mutually_assured_destruction => player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) && player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2),
      :war => player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
    }
    if turn_type.key(true) == :basic
      if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
        player1
      else
        player2
      end
    elsif turn_type.key(true) == :war
      if player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2)
        player1
      else
        player2
      end
    else
      "No Winner"
    end
  end

  def pile_cards
    turn_type = {
      :basic => player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0),
      :mutually_assured_destruction => player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) && player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2),
      :war => player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
    }
    if turn_type.key(true) == :basic
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
      @spoils_of_war
    elsif turn_type.key(true) == :war
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
      @spoils_of_war
    else
      player1.deck.remove_card
      player2.deck.remove_card
      player1.deck.remove_card
      player2.deck.remove_card
      player1.deck.remove_card
      player2.deck.remove_card
      @spoils_of_war
    end
  end

  def award_spoils(winner)
    @spoils_of_war.each do |spoil|
      winner.deck.cards << spoil
    end
    winner.deck.cards
  end
end
