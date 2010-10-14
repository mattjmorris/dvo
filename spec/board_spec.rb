require "spec"
require File.dirname(__FILE__) +"/../src/board"
require File.dirname(__FILE__) +"/../src/piece"

describe Board do

  before(:each) do
    @board = Board.new
  end

 it "contains all of the spaces on a dvonn board" do
    @board.spaces.length.should == 49
    @board.spaces.sort.map{|s| s.position}.should ==
                        [:a5, :a4, :a3,
                      :b5, :b4, :b3, :b2,
                    :c5, :c4, :c3, :c2, :c1,
                  :d5, :d4, :d3, :d2, :d1,
                :e5, :e4, :e3, :e2, :e1,
              :f5, :f4, :f3, :f2, :f1,
            :g5, :g4, :g3, :g2, :g1,
          :h5, :h4, :h3, :h2, :h1,
       :i5, :i4, :i3, :i2, :i1,
         :j4, :j3, :j2, :j1,
           :k3, :k2, :k1]
  end

  it "it's spaces know the positions of their neighbors" do
    @board.space(:a5).neighbor_positions.should == [:b4, :b5, nil, nil, nil, :a4]
    @board.space(:c1).neighbor_positions.should == [nil, :d1, :c2, :b2, nil, nil]
    @board.space(:c2).neighbor_positions.should == [:d1, :d2, :c3, :b3, :b2, :c1]
    @board.space(:k3).neighbor_positions.should == [nil, nil, nil, :j4, :j3, :k2]
  end

  it "reports all reachable positions, in clockwise order, when given a starting position and number of hops" do
    @board.reachable_positions(:f3, 0).should == [:f3, :f3, :f3, :f3, :f3, :f3]
    @board.reachable_positions(:f3, 1).should == [:g2, :g3, :f4, :e4, :e3, :f2]
    @board.reachable_positions(:f3, 2).should == [:h1, :h3, :f5, :d5, :d3, :f1]
    @board.reachable_positions(:f3, 3).should == [nil, :i3, nil, nil, :c3, nil]
    @board.reachable_positions(:f3, 4).should == [nil, :j3, nil, nil, :b3, nil]
    @board.reachable_positions(:f3, 5).should == [nil, :k3, nil, nil, :a3, nil]
    @board.reachable_positions(:f3, 6).should == [nil, nil, nil, nil, nil, nil]
  end

  it "defaults to using the number of pieces on the space at a position when reporting reachable positions" do
    @board.space(:f3).place_pieces(Piece.new(:black), Piece.new(:white))
    @board.reachable_positions(:f3).should == [:h1, :h3, :f5, :d5, :d3, :f1]
  end

  it "will move pieces from one space to another, assuming no rules are violated" do
    board = Board.new
    board.space(:c2).place_piece(:black)
    board.space(:c3).place_piece(:white)
    board.move_pieces(:black, :c2, :c3)
    board.space(:c2).pieces.should be_empty
    board.space(:c3).pieces.size.should be(2)
    board.space(:c3).owner.should be(:black)
  end

  it "raises a MoveError if a player tries to move pieces from a space that they do not control" do
    board = Board.new
    board.space(:c2).place_piece(:black)
    board.space(:c3).place_piece(:white)
    lambda{board.move_pieces(:white, :c2, :c3)}.should raise_error(MoveError, "Origin position is not controlled by white")    
  end

  it "raises a MoveError if a player tries to move pieces from a space that is surrounded" do
    board = Board.new
    c2_neighbors = [:d1, :d2, :c3, :b3, :b2, :c1]
    c2_neighbors.each{|p| board.space(p).place_piece(:black)}
    board.space(:c2).place_piece(:white)
    lambda{board.move_pieces(:white, :c2, :c3)}.should raise_error(MoveError, "Origin position is surrounded")
  end

  it "raises a MoveError if a player tries to move pieces to a space that is not along a direct line" do
    board = Board.new
    board.space(:c5).place_piece(:black)
    board.space(:b4).place_piece(:white)
    lambda{board.move_pieces(:black, :c5, :b4)}.should raise_error(MoveError, "Destination is not reachable from origin")
  end

  it "raises a MoveError if a player tries to move pieces to a space that is the wrong distance away" do
    board = Board.new
    board.space(:d3).place_pieces(:white, :black)
    board.space(:c3).place_piece(:white)
    board.space(:g3).place_piece(:white)
    # 1 space away is not 'reachable' if your stack is size 2
    lambda{board.move_pieces(:black, :d3, :c3)}.should raise_error(MoveError, "Destination is not reachable from origin")
    # 3 spaces away is not 'reachable' if your stack is size 2
    lambda{board.move_pieces(:black, :d3, :g3)}.should raise_error(MoveError, "Destination is not reachable from origin")
  end

   it "raises a MoveError if a player tries to move pieces to a space that is empty" do
    board = Board.new
    board.space(:c2).place_piece(:black)
    board.space(:c3).clear
    lambda{board.move_pieces(:black, :c2, :c3)}.should raise_error(MoveError, "Destination position is empty")    
   end

  it "knows its occupied positions" do
    board = Board.new
    board.space(:c2).place_piece(:black)
    board.space(:c3).place_piece(:white)
    board.occupied_positions.should include(:c2)
    board.occupied_positions.should include(:c3)
  end

  it "can clear all of its spaces" do
    board = Board.new
    board.space(:c2).place_piece(:black)
    board.space(:c3).place_piece(:white)
    board.clear
    board.space(:c2).should be_empty
    board.space(:c3).should be_empty
  end
end                                                 