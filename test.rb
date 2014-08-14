require "./game.rb"


puts "1. Black can move to 1, 1 from 0, 0"
b = Board.new(false)
p1 = Piece.new([0, 0], :black, b)
b[[0, 0]] = p1

puts p1.valid_moves == [[1, 1]]

puts "2. White can move to 6, 3 and 6, 5 from 7, 4"
b = Board.new(false)
p1 = Piece.new([7, 4], :white, b)
b[[7, 4]] = p1

puts p1.valid_moves.include?([6, 3]) && p1.valid_moves.include?([6, 5])

puts "3. blocked White can move to 6, 3 and from 7, 4"
b = Board.new(false)
p1 = Piece.new([7, 4], :white, b)
p2 = Piece.new([6, 5], :white, b)
b[[7, 4]] = p1
b[[6, 5]] = p2

puts p1.valid_moves == [[6, 3]]

puts "4. White at 7, 7 can jump over Black at 6, 6 to land on 5, 5"
b = Board.new(false)
p1 = Piece.new([7, 7], :white, b)
p2 = Piece.new([6, 6], :black, b)
b[[7, 7]] = p1
b[[6, 6]] = p2

puts p1.valid_moves == [[5, 5]]

puts "5. empty? works"
pos = [4, 4]
puts b.empty?(pos) == true

puts "6. White jumps over black or slides"
b = Board.new(false)
p1 = Piece.new([7, 5], :white, b)
p2 = Piece.new([6, 6], :black, b)
b[[7, 7]] = p1
b[[6, 6]] = p2

puts p1.valid_moves.include?([5, 7]) && p1.valid_moves.include?([6, 4])

puts "7. White promoted to king. Black promoted to king."
b = Board.new(false)
p1 = Piece.new([0, 5], :white, b)
p2 = Piece.new([7, 3], :black, b)
b[[0, 5]] = p1
b[[7, 3]] = p2
p1.king = true if p1.promote?
p2.king = true if p2.promote?

puts p1.king == true && p2.king == true
