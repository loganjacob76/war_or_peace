require './lib/card'

class Deck
  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
    # @face_cards = []
  end

  def rank_of_card_at(index)
    cards[index].rank
  end

  def high_ranking_cards
    cards.find_all do |card|
      card.rank > 10
    end
  end

  def percent_high_ranking
    face_cards = cards.find_all do |card|
      card.rank > 10
    end
    ((face_cards.length.to_f / cards.length.to_f) * 100).round(2)
  end

  def remove_card
    cards.shift
  end

  def add_card(new_card)
    cards << new_card
  end
end
