require File.dirname(__FILE__) + "/piece"

class Space
  attr_accessor :position, :neighbor_positions
  attr_reader :pieces

  def initialize(position)
    @position           = position
    @pieces             = []
    @neighbor_positions = Array.new(6)
  end

  def place_pieces(*pieces)
    # as a convenience, allow color symbols to be passed in instead for full pieces
    pieces.map! { |p| Piece.new(p) } if pieces[0].class == Symbol
    @pieces << pieces
    @pieces.flatten!
  end

  # a convenience method that can be used when placing a single piece.  
  def place_piece(piece)
    place_pieces(piece)
  end

  # which player, or dvonn, or nil, controls the space
  def owner

    return nil if @pieces.empty?

    # TODO - can I use 'peek' here?  Might make code more obvious
    case @pieces[-1].color
      when :white then :white
      when :black then :black
      when :red then :dvonn
      else raise "Unknown top piece color: #{@pieces[-1].color}"
    end

  end

  def clear
    @pieces = []
  end

  # sorting alphabetically first, then reverse by integer produces the typical board configuration
  def <=>(other)
    # note that the 6-pos[1] transform only works when assuming the board has max 5 rows for any letter
    # the point of this transform is to temporarily make :a1 -> :a5, :a2 -> :a4, etc., so ordering will go
    # :a5, :a4, :a3, :a2, :a1, :b5, :b4...
    my_transformed_position    = (@position[0] + (6 - @position[1].to_i).to_s).to_sym
    other_transformed_position = (other.position[0] + (6 - other.position[1].to_i).to_s).to_sym
    my_transformed_position <=> other_transformed_position
  end

  def empty?
    @pieces.empty?
  end

  # TODO: needs unit test
  def pretty_print

    letter = case owner
               when :white then
                 "w"
               when :black then
                 "b"
               when :dvonn then
                 "r"
               else
                 "."
             end

    # if this is a stack that has a dvonn, make the letter capital
    letter.upcase if ((letter == "w" || "b") && !@pieces.empty? && @pieces[0].color == :red)

    letter += @pieces.size.to_s unless @pieces.empty?

    letter

  end

end