require './lib/card'
require './lib/deck'

class Player
  attr_reader :name,
              :deck

  def initialize(name, deck)
    @name = name
    @deck = deck
    @victorious
  end

  def has_lost?
    if @deck.cards == []
      @victorious = true
    else
      @victorious = false
    end
  end
end
