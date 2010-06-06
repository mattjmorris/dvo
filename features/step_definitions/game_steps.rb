require File.dirname(__FILE__) + "/../../src/board"
require File.dirname(__FILE__) + "/../../src/game"

Given /^a blank board$/ do
  @board = Board.new
  @board.extend(Game)
end

Given /^the following moves:$/ do |table|

  table = table.transpose
  table.hashes.each do |move_hash|

    piece = case move_hash[:piece]
      when "r" then :red
      when "b" then :black
      when "w" then :white
    end

    position = move_hash[:position]
    
    @board.space(position.to_sym).place_piece(piece)

  end
end

Then /^I should see the board:$/ do |table|
  # produces [:c1, :d1, :e1, :f1, :g1, :h1, :i1, :j1, :k1, :b2, :c2, :d2, :e2, :f2, :g2, ..., :i5]
  sorted_by_rows = @board.spaces.sort{|x,y| (x.position[1] + x.position[0]) <=> (y.position[1] + y.position[0])}.map{|s| s.position}

  positions_by_row = {}
  (1..5).each do |row|
    positions_by_row[row] = sorted_by_rows.find_all{|p| p =~ /^.#{row}$/}
  end

  row_strings = []
  positions_by_row.each do |row, pos_array|
    row_string = ""
    pos_array.each do |pos|
      row_string += @board.space(pos).pretty_print
    end
    row_strings << row_string
  end

  table.hashes.each_with_index do |expected_strings, idx|
    row_strings[idx].should == expected_strings["stacks"].gsub(/ /,'')
  end

end

Given /^the following board:$/ do |table|

  @board = Board.new
  @board.extend(Game)
  
  table.hashes.each_with_index do |row_strings, row|

    pieces = row_strings["stacks"].scan(/\S\d/)
    letters = nil

    row += 1
    case row
      when 1 then letters = ('c'..'k').to_a
      when 2 then letters = ('b'..'k').to_a
      when 3 then letters = ('a'..'k').to_a
      when 4 then letters = ('a'..'j').to_a
      when 5 then letters = ('a'..'i').to_a
    end
    
    pieces.each_with_index do |piece, idx|
      piece[1].to_i.times{ @board.space((letters[idx]+row.to_s).to_sym).place_piece(Piece.new(piece[0].to_sym)) }
    end

  end

end

When /^I permform the following moves:$/ do |table|
  table.hashes.each do |move|
    @board.move_pieces(move["player"].to_sym, move["position_1"].to_sym, move["position_2"].to_sym)
  end
  
end
