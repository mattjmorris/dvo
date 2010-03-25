class Space
  attr_reader :position, :pieces

  def initialize(position)
    @position = position
    @pieces = []
  end

  def place_piece(piece)
    @pieces << piece
  end

  def take_pieces(other)
    validate_movement(other)
    @pieces << other.pieces
    @pieces.flatten!
    other.clear
  end

  def clear
    @pieces = nil
  end

  private

  def validate_movement(other)
    if line_of_movement_ok? && num_spaces_ok?
      return true
    else
      # return error for stated reasons - not in direct line, piece surrounded, number of spaces incorrect
#      raise MovementError, "Cannont move stack of size #{other.pieces.size} from #{other.position} to #{self.position}"
    end
  end

end