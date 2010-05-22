class Piece

  attr_reader :color

  def initialize(color)
    raise ArgumentError, "Colors must be :black, :white, or :red" unless %w(black white red).map!{|c| c.to_sym}.include?(color)
    @color = color
  end

  # TODO- are these methods used anywhere?
  def black?
    @color == :black
  end

  def white?
    @color == :white
  end

  def red?
    @color == :red
  end
  
end