require File.dirname(__FILE__) + "/space"
require File.dirname(__FILE__) + "/move_error"

class Board
  attr_reader :spaces

  POSITIONS_NOT_ON_BOARD ||= [:a1, :a2, :b1, :j5, :k4, :k5]
  POSITION_NUMBERS ||= [1, 2, 3, 4, 5]
  POSITION_LETTERS ||= [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k]
  NUM_NEIGHBORS = 6
  LETTER_NEIGHBOR_MAPPING = [+1, +1, 0, -1, -1, 0]
  NUMBER_NEIGHBOR_MAPPING = [-1, 0, +1, +1, 0, -1]

  def initialize
    @spaces = create_spaces
  end

  # Return the space at a particular position 
  def space(position)
    return nil_space if position.nil?
    @spaces.find{|s| s.position == position}
  end

  # move pieces from one origin position's space to destination position's space, returning errors if any rules are violated
  def move_pieces(player, origin_position, destination_position)
    validate_move(player, origin_position, destination_position)
    space(destination_position).place_pieces(space(origin_position).pieces)
    space(origin_position).clear
  end

  # Returns positions, in 'clockwise' order, that can be reached within num_hops from the starting position
  def reachable_positions(starting_position, num_hops = nil)

    # default to look at spaces reachable with the current pieces on the reference space
    num_hops ||= space(starting_position).pieces.size

    # use spaces since spaces know how to look up their neighbors
    target_spaces = Array.new(NUM_NEIGHBORS, space(starting_position))
    num_hops.times do
      target_spaces.each_with_index do |target_space, idx|
        next_position = target_space.neighbor_positions[idx]
        target_spaces[idx] = space(next_position)
      end
    end

    return target_spaces.collect(&:position)

  end

  # Returns all occupied positions on the board, in the format: [:a2, :a3, :b2]
  def occupied_positions
    spaces.map{ |s| s.position unless s.pieces.empty? }.compact
  end

  # clear the whole board of any pieces
  def clear
    spaces.each{|s| s.clear}
  end

  private

  def validate_move(player, origin_position, destination_position)

# ------------ DELETE THIS BEFORE CHECKING IN ! ----------------
puts
puts "*" * 50
p player
p origin_position
p destination_position
puts "*" * 50
# --------------------------------------------------------------

    # validate that the top piece at origin is owned by the player requesting the move
    raise MoveError,"Origin position is not controlled by #{player}" unless space(origin_position).owner == player

    # make sure origin position is not surrounded
    raise MoveError,"Origin position is surrounded" unless position_has_at_least_one_empty_neighbor(origin_position)

    # validate that the destination is reachable from the origin
    raise MoveError,"Destination is not reachable from origin" unless reachable_positions(origin_position).include?(destination_position)

    # make sure the destination position is not empty
    raise MoveError,"Destination position is empty" if space(destination_position).pieces.empty?

  end

  def position_has_at_least_one_empty_neighbor(position)
# ------------ DELETE THIS BEFORE CHECKING IN ! ----------------
puts
puts "*" * 50
p space(position).neighbor_positions
puts "*" * 50
# --------------------------------------------------------------

    space(position).neighbor_positions.find{|p| space(p).pieces.empty?}
  end

  def nil_space
    Space.new(nil)
  end

  def create_spaces
    @positions = get_all_positions
    @spaces = create_a_space_for_each_position(@positions)
    set_neighbor_positions(@spaces)
  end

  # Returns all positions that are on the board, in the format: [:a3, :a4, :b2, :b3, .. :k2, :k3]
  def get_all_positions

    positions = []
    POSITION_NUMBERS.each do |number|
      POSITION_LETTERS.each do |letter|
        positions << eval(":#{letter}#{number}")
      end
    end
    positions -= POSITIONS_NOT_ON_BOARD

    return positions

  end

  # Returns an array of Space objects for each position passed in
  def create_a_space_for_each_position(positions)
    spaces = []
    positions.each{|position| spaces << Space.new(position)}
    return spaces
  end

  # give each space its neighbor_positions
  def set_neighbor_positions(spaces)
    spaces.each do |space|
      space.neighbor_positions = get_neighboring_positions(space.position)
    end
  end

  # return neighboring positions in clockwise order starting at top right, such that
  # positions[0] -> top right, positions[1] -> right, .., positions[4] -> left, positions[5] -> top left
  def get_neighboring_positions(position)

    letter_sym = position.slice(0).to_sym
    number = position.slice(1).to_i
    neighboring_positions = Array.new(6)
    neighboring_positions.each_with_index do |p, idx|
      neighboring_positions[idx] = get_position(letter_sym, number, idx)
    end

    # make nil any positions that are not on the board
    neighboring_positions.map!{|p| @positions.include?(p) ? p : nil}
    neighboring_positions

  end

  def get_position(letter_sym, number, idx)

    index_of_letter = POSITION_LETTERS.index(letter_sym) + LETTER_NEIGHBOR_MAPPING[idx]
    return if index_of_letter < 0
    new_letter = POSITION_LETTERS.slice(index_of_letter)
    return if new_letter.nil?

    index_of_number = POSITION_NUMBERS.index(number) + NUMBER_NEIGHBOR_MAPPING[idx]
    return if index_of_number < 0
    new_number = POSITION_NUMBERS.slice(index_of_number)
    return if new_number.nil?

    return eval(":#{new_letter}#{new_number}")

  end

end