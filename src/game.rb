# Right now this represents the 'standard' Dvonn game and its rules
require File.dirname(__FILE__) + "/analyzer"

# TODO: Enforce rules for different parts of the game - board setup, ...

module Game
  include Analyzer, Loggit

  def self.extended(object)
    class << object
      alias :move_pieces_orig :move_pieces
      alias :move_pieces :move_pieces_with_cutoffs
    end
  end

  # game is over when neither player can make any moves
  def game_over?
    possible_moves(:white).empty? && possible_moves(:black).empty?    
  end

  # whoever has the highest cumulative stacks at the moment
  def leader
    white_size = cumulative_stack_size(:white)
    black_size = cumulative_stack_size(:black)
    case white_size <=> black_size
      when 1 then :white
      when 0 then :tie
      when -1 then :black
    end
  end

  # TODO: This algorithm will do duplicate work for certain spaces - make more efficient!
  #------------------------
  # Look to see if need to remove any pieces after the move because the pieces were cut off from a dvonn piece
  # Note that this method aliases the move_pieces method
  def move_pieces_with_cutoffs(player, origin_position, destination_position)

    move_pieces_orig(player, origin_position, destination_position)

    # find all spaces that contain a dvonn piece.  Conceptualize these as starters of an infection.
    infected_positions = dvonn_spaces

    # now, find which spaces are further infected
    newly_infected = infected_positions.map{ |i| occupied_neighbors(i) }.flatten

    infected = infected_positions + newly_infected
    while !newly_infected.empty?
      newly_infected = newly_infected.map{ |i| occupied_neighbors(i) }.flatten - infected
      infected += newly_infected
    end

    # remove pieces from any spaces that are not 'infected' by dvonn's
    to_remove = occupied_positions - infected.uniq

    to_remove.each{ |p| space(p).clear }

    $LOG.info("Removed the following cut off spaces: #{to_remove}") unless to_remove.empty?
    
  end

  private

  def cumulative_stack_size(color)
    spaces.find_all{|s| s.owner == color}.inject(0){|sum, space| sum += space.pieces.size}
  end

  def dvonn_spaces
    spaces.find_all{ |s| s.pieces.collect(&:color).include?(:red) }.map{ |s| s.position}
  end

  def occupied_neighbors(position)
#puts "looking at occupied neighbors for #{position}"
    space(position).neighbor_positions.find_all{ |p| !space(p).pieces.empty? }
  end

end