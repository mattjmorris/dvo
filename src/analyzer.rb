module Analyzer

  def possible_moves(player)
    # find all spaces controlled by player
    players_spaces = spaces.find_all{|s| s.owner == player}
    moves = {}
    players_spaces.each do |space|
      reachable_non_nil_positions = []
      reachable_positions(space.position).each do |reachable_position|
        # TODO - create an easier accessor for board.space(reachable_position).pieces.empty?
         reachable_non_nil_positions << reachable_position unless space(reachable_position).pieces.empty?
      end
      moves[space.position] = reachable_non_nil_positions unless reachable_non_nil_positions.empty?
    end
    moves
  end

end