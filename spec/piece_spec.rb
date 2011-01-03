require "spec"
require File.dirname(__FILE__) + "/../src/piece"

describe Piece do

  it "has a color of :black, white, or red" do

    black = Piece.new(:black)
    black.color.should == :black

    white = Piece.new(:white)
    white.color.should == :white

    red = Piece.new(:red)
    red.color.should == :red
  end

  it ":b, :w, and :r may be used as short-cuts for :black, :white, and :red" do

    black = Piece.new(:b)
    black.color.should == :black

    white = Piece.new(:w)
    white.color.should == :white

    red = Piece.new(:r)
    red.color.should == :red

  end

  it "should raise an ArgumentError if instantiated with an incorrect color" do
    expect { Piece.new(:green) }.to raise_error(ArgumentError, "Colors must be :black/:b, :white/:w, or :red/:r.  You passed in green")
  end

end