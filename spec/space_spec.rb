require "spec"
require File.dirname(__FILE__) + "/../src/space"
require File.dirname(__FILE__) + "/../src/piece"

describe Space do

  it "has a position" do
    a5 = Space.new(:a5)
    a5.position.should be(:a5)
  end

  it "contains zero or more pieces" do
    a5 = Space.new(:a5)
    a5.pieces.should be_empty
    a5.place_pieces(Piece.new(:black), Piece.new(:white))
    a5.pieces.should_not be_empty
  end

  it "holds an array of neighbor positions" do
    a5 = Space.new(:a5)
    a5.neighbor_positions = [:b4, :b5, nil, nil, nil, :a4]
    a5.neighbor_positions.should_not be_empty
  end

  it "reports which player owns that space, based on the color of the top piece" do

    a5 = Space.new(:a5)

    a5.place_piece(Piece.new(:black))
    a5.owner.should be(:black)

    a5.place_piece(Piece.new(:white))
    a5.owner.should be(:white)

    a5.clear
    a5.place_piece(Piece.new(:red))
    a5.owner.should be(:dvonn)

    a5.clear
    a5.owner.should be(nil)    

  end

  it "should allow color symbols to be passed in to place_piece(s), in additional to Piece objects" do
    a5 = Space.new(:a5)
    a5.place_pieces(:red, :white)
    a5.pieces.map{|p| p.color}.should == [:red, :white]
  end

  it "should report if it is empty" do
    a5 = Space.new(:a5)
    a5.should be_empty
    a5.place_pieces(:red, :white)
    a5.should_not be_empty
  end

end