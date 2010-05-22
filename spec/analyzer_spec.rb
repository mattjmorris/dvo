require "spec"
require File.dirname(__FILE__) + "/../src/board"
require File.dirname(__FILE__) + "/../src/analyzer"

describe "A board extended with analyzer" do

  before(:all) do
    @board = Board.new
    @board.extend(Analyzer)
  end

  it "should tell you a player's possible moves, in the format: {:position_1 => [:position_a, :position_b, ...], ...}" do
    @board.space(:c2).place_piece(:black)
    @board.space(:b2).place_piece(:red)
    @board.space(:c3).place_pieces(:red, :white)
    @board.possible_moves(:black).keys.should == [:c2]
    @board.possible_moves(:black)[:c2].sort.should == [:b2, :c3]
    @board.possible_moves(:white).should == {}
  end

end