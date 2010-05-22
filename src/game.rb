# Right now this represents the 'standard' Dvonn game and its rules
require File.dirname(__FILE__) + "/analyzer"

module Game
  include Analyzer

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

  # Look to see if need to remove any pieces after the move because the pieces were cutt off from a dvonn piece
  def move_pieces_with_cutoffs(player, origin_position, destination_position)
    move_pieces_orig(player, origin_position, destination_position)
    # find all spaces that contain a dvonn piece
    dvonn_spaces = spaces.find_all{ |s| s.pieces.collect(&:color).include?(:red) }
    # now, find all spaces that are connected to the dvonns
    connected_spaces = []
    dvonn_spaces.each do |dvonn_space|
      # TODO - traverse all connected paths
      occupied_neighbors = dvonn_space.neighbor_positions.find{ |p| !space(p).pieces.empty? }
      connected_spaces << occupied_neighbors
    end
    # remove pieces from any spaces that are not members of connected_spaces
    
  end

  private

  def cumulative_stack_size(color)
    spaces.find_all{|s| s.owner == color}.inject(0){|sum, space| sum += space.pieces.size}
  end

end