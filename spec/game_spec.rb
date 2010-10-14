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

  it "reports that a game is over when no more moves can be made" do
    @board.space(:c2).place_piece(:black)
    @board.space(:b2).place_piece(:red)
    @board.game_over?.should be(false)
    @board.move_pieces(:black, :c2, :b2)
    @board.game_over?.should be(true)
  end

  it "tells you who the current leader is" do
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
    @board.space(:d1).place_piece(:white)
    @board.space(:d2).place_piece(:red)
    @board.space(:e1).place_piece(:white)
    @board.space(:e2).place_piece(:white)
    @board.space(:e3).place_piece(:black)
    @board.space(:e4).place_piece(:black)
    @board.space(:e5).place_piece(:white)
    @board.space(:f1).place_piece(:white)
    @board.space(:g1).place_piece(:red)
    @board.space(:i2).place_piece(:red)
    @board.space(:j2).place_piece(:black)
    @board.move_pieces(:white, :c2, :d2)
    @board.space(:b2).should be_empty
    %w(d1 d2 e1 e2 e3 e4 e5 f1 g1 i2 j2).each do |pos|
      @board.space(pos.to_sym).should_not be_empty
    end

    
    # TODO - message system that reports which pieces were cut off and removed
  end

end