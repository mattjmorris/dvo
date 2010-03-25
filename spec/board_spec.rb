require "spec"
require File.dirname(__FILE__) +"/../src/board"

describe Board do

  it "should contain multiple spaces" do
    board = Board.new
    board.spaces.empty?.should be(false)
  end
end