require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require 'pry'

complete_deck = []

ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]

ranks.each do |rank|
  faces = if rank == 11
    "Jack"
  elsif rank == 12
    "Queen"
  elsif rank == 13
    "King"
  elsif rank == 14
    "Ace"
  else
    rank.to_s
  end
  complete_deck << Card.new(:hearts, faces, rank)
end

ranks.each do |rank|
  faces = if rank == 11
    "Jack"
  elsif rank == 12
    "Queen"
  elsif rank == 13
    "King"
  elsif rank == 14
    "Ace"
  else
    rank.to_s
  end
  complete_deck << Card.new(:diamonds, faces, rank)
end

ranks.each do |rank|
  faces = if rank == 11
    "Jack"
  elsif rank == 12
    "Queen"
  elsif rank == 13
    "King"
  elsif rank == 14
    "Ace"
  else
    rank.to_s
  end
  complete_deck << Card.new(:clubs, faces, rank)
end

ranks.each do |rank|
  faces = if rank == 11
    "Jack"
  elsif rank == 12
    "Queen"
  elsif rank == 13
    "King"
  elsif rank == 14
    "Ace"
  else
    rank.to_s
  end
  complete_deck << Card.new(:spades, faces, rank)
end

split_decks = complete_deck.shuffle.each_slice(26).to_a

deck1 = Deck.new(split_decks[0])
deck2 = Deck.new(split_decks[1])

player1 = Player.new("Megan", deck1)
player2 = Player.new("Aurora", deck2)
