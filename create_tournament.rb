# ultimate goal: every player has each other player as a partner once, playing for n-1 rounds
# this goal takes precedence over others

#require 'awesome_print'
#
# debugging
require 'byebug'

class Player
  attr_reader :player_number
  def initialize(game, player_number)
    @game = game
    @player_number = player_number
  end

  def potential_pairs 
    byebug
    @game.partner_pairs.select { |pair| pair.include?(self) }
  end

#  def inspect
#    "\nPlayer #{@player_number}\npotential_pairs: #{Game.stringify_partner_pairs(potential_pairs)}"
#  end

end

class PlayerPair
  def intialize(player_pair)
    @players = player_pair
  end

  def inspect
    [@players[0].player_number, @players[1].player_number]
  end
end

class Game
  attr_reader :partner_pairs
  #TODO: below accessors only for debugging - revisit program scoping before use
  attr_accessor :players, :num_players
  

  def initialize(num_players = 12)
    @num_players = num_players
    @players = create_players
    @partner_pairs = create_partners
    @past_partners = []
  end

  def create_players
    players = []
    @num_players.times do |k|
      players << Player.new(self, k)
    end
    return players
  end

  def create_partners
    byebug
    @players.combination(2) { |pair| PlayerPair.new(pair) }
  end

  def self.stringify_partner_pairs(pairs_arr)
    pairs_arr.map { |pair| [ pair[0].player_number, pair[1].player_number ] }
  end

  def inspect
    "\nGame: \n\t@num_players: #{@num_players} \n\t@partner_pairs: #{self.stringify_partner_pairs(@partner_pairs)} \n\ttotal_pairs: #{@partner_pairs.size}"
  end

end
