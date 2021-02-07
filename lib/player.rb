require './lib/card'
require './lib/deck'

class Player
  attr_reader :name,
              :deck

  def initialize(name, deck)
    @name = name
    @deck = deck
    @loss
  end

  def has_lost?
    if @deck.cards == []
      @loss = true
    else
      @loss = false
    end
  end
end
