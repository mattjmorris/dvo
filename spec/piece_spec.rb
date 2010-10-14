require "spec"
require File.dirname(__FILE__) + "/../src/piece"

describe Piece do

  it "is black, white, or red" do

    black = Piece.new(:black)
    black.should be_black
    black.should_not be_white
    black.should_not be_red

    white = Piece.new(:white)
    white.should be_white
    white.should_not be_black
    white.should_not be_red

    red = Piece.new(:red)
    red.should be_red
    red.should_not be_black
    red.should_not be_white

  end

  it "raises an ArgumentError if instantiated with an incorrect color" do
    expect { Piece.new(:green) }.to raise_error(ArgumentError, "Colors must be :black, :white, or :red")
  end

end