require File.dirname(__FILE__) + "/../../src/board"
require File.dirname(__FILE__) + "/../../src/game"

Given /^a blank board$/ do
  @board = Board.new
  @board.extend(Game)
end

Given /^the following moves:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |move_hash|
    piece = move_hash[:piece]
    position = move_hash[:position]
    @board.space(position.to_sym).place_piece(piece.to_sym)
  end
end

Then /^I should see the board$/ do
  p @board.spaces.sort.map{|s| s.position}
  p @board.spaces.sort.map{|s| s.pieces.map {|p| p.color if p}}
end