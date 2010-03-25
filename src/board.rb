class Board
  attr_reader :spaces

  def initialize
    @spaces = create_spaces
  end

  private

  def create_spaces
    a = [:a3, :a4, :a5, :b2, :b3, :b4, :b5, :j1, :j2, :j3, :j4, :k1, :k2, :k3]
    nums = [1, 2, 3, 4, 5]
    letters = [:c, :d, :e, :f, :g, :h, :i]
    combos = []
    nums.each do |number|
      letters.each do |letter|
        combos << eval(":#{letter}#{number}")
      end
    end
    combos += a

    spaces = []
    combos.each{|position| spaces << Space.new(position)}
    return spaces
  end

end