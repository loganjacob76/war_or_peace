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

class Game
  attr_reader :player1,
              :player2,
              :turn_number

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_number = 0
  end

  def start
    p "Welcome to War! (or Peace) This game will be played with 52 cards. The players today are #{player1.name} and #{player2.name}. Type 'GO' to start the game!"
    p "------------------------------------------------------------------------------"
    print "> "
    starter = gets.chomp.upcase
    if starter == "GO"
      until @player1.has_lost? == true || @player2.has_lost? == true || @turn_number == 1000000 do
        @turn_number += 1
        turn = Turn.new(@player1, @player2)
        if turn.type == :basic
          winner = turn.winner
          turn.pile_cards
          turn.award_spoils(winner)
          p "Turn #{@turn_number}: #{winner.name} won 2 cards"
        elsif turn.type == :war
          winner = turn.winner
          turn.pile_cards
          turn.award_spoils(winner)
          p "Turn #{@turn_number}: WAR - #{winner.name} won 6 cards"
        elsif turn.type == :mutually_assured_destruction
          turn.pile_cards
          p "Turn #{@turn_number}: *mutually assured destruction* 6 cards removed from play"
        end

        if @player1.has_lost? == true
          p "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
        elsif @player2.has_lost? == true
          p "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
        elsif @turn_number == 1000000
          p "---- DRAW ----"
        end
      end
    else
      p "Go only, GAME OVER!"
    end
  end
end

game = Game.new(player1, player2)

game.start
