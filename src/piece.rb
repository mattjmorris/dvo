class Piece

  attr_reader :color

  def initialize(color)
    raise ArgumentError, "Colors must be :black/:b, :white/:w, or :red/:r.  You passed in #{color}" unless %w(black white red b w r).map!{|c| c.to_sym}.include?(color)

    # as a convenience, allow :w, :b, or :r to be passed in in lieu of longer color symbol
    case color
      when :w then color = :white
      when :b then color = :black
      when :r then color = :red
    end
    
    @color = color
  end
  
end