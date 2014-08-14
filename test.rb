require "./game.rb"


puts "1. Black can move to 1, 1 from 0, 0"
b = Board.new(false)
p1 = Piece.new([0, 0], :black, b)
b[[0, 0]] = p1

puts p1.valid_moves.include?([1, 1])

puts "2. White can move to 6, 3 and 6, 5 from 7, 4"
b = Board.new(false)
p1 = Piece.new([7, 4], :white, b)
b[[7, 4]] = p1

puts p1.valid_moves.include?([6, 3]) && p1.valid_moves.include?([6, 5])

puts "2. White can move to 6, 3 and 6, 5 from 7, 4"
b = Board.new(false)
p1 = Piece.new([7, 4], :white, b)
p2 = Piece.new([6, 5], :white, b)
b[[7, 4]] = p1
b[[6, 5]] = p2

puts p1.valid_moves.include?([6, 3])