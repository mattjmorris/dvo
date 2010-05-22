require "spec"
require File.dirname(__FILE__) + "/../src/board"
require File.dirname(__FILE__) + "/../src/game"

describe "A board extended with game" do

  before(:all) do
    @board = Board.new
    @board.extend(Game)
  end

  before(:each) do
    @board.clear
  end

  it "should tell you when a game is over" do
    @board.space(:c2).place_piece(:black)
    @board.space(:b2).place_piece(:red)
    @board.game_over?.should be(false)
    @board.move_pieces(:black, :c2, :b2)
    @board.game_over?.should be(true)
  end

  it "should tell you who the current leader is" do
    @board.space(:b2).place_piece(:black)
    @board.space(:c2).place_piece(:red)
    @board.space(:d2).place_piece(:white)
    @board.leader.should be(:tie)
    @board.move_pieces(:black, :b2, :c2)
    @board.leader.should be(:black)
    @board.move_pieces(:white, :d2, :c2)
    @board.leader.should be(:white)
  end

  it "should remove pieces that have been cut off" do
    @board.space(:b2).place_piece(:black)
    @board.space(:c2).place_piece(:white)
    @board.space(:d2).place_piece(:red)
    @board.space(:e2).place_piece(:white)
    @board.move_pieces(:white, :c2, :d2)
    @board.space(:b2).should be_empty
    @board.space(:e2).should_not be_empty
    # TODO - message system that reports which pieces were cutt off and removed
  end

end