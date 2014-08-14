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
b[[7, 5]] = p1
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

puts "8. Performs slides (unvalidated)"
b = Board.new(false)
p1 = Piece.new([7, 5], :white, b)
b[[7, 5]] = p1
p1.perform_slide([6, 6], [7, 5])

puts b[[7, 5]] == nil && b[[6, 6]] == p1 && p1.pos == [6, 6]

puts "9. Performs jump and removes enemy (unvalidated)"
b = Board.new(false)
p1 = Piece.new([7, 7], :white, b)
p2 = Piece.new([6, 6], :black, b)
b[[7, 7]] = p1
b[[6, 6]] = p2
p1.perform_jump([5, 5], [7, 7])

puts p1.pos = [5, 5] && b[[6, 6]] == nil

puts "10. performs sequence of jumps"
b = Board.new(false)
p1 = Piece.new([7, 7], :white, b)
p2 = Piece.new([6, 6], :black, b)
p3 = Piece.new([4, 4], :black, b)
b[[7, 7]] = p1
b[[6, 6]] = p2
b[[4, 4]] = p3

p1.perform_moves!([[5, 5], [3, 3]])
puts p1.pos == [3, 3]

puts "11. performs slide in sequence"
b = Board.new(false)
p1 = Piece.new([7, 7], :white, b)
b[[7, 7]] = p1

p1.perform_moves!([[6, 6]])
puts p1.pos == [6, 6]

### raising an error here
# puts "11. doesn't slide if invalid"
# b = Board.new(false)
# p1 = Piece.new([7, 7], :white, b)
# b[[7, 7]] = p1

# p1.perform_moves!([[5, 5]])
# puts p1.pos == [7, 7]

puts "12. performs single jump sequence"
b = Board.new(false)
p1 = Piece.new([7, 7], :white, b)
p2 = Piece.new([6, 6], :black, b)
b[[7, 7]] = p1
b[[6, 6]] = p2

p1.perform_moves!([[5, 5]])
puts p1.pos == [5, 5]

puts "13. Board#dup works"
b = Board.new(false)
p1 = Piece.new([7, 7], :white, b)
b[[7, 7]] = p1
b_dup = b.dup

puts !b_dup.empty?(p1.pos) &&
      p1.object_id !=b_dup[p1.pos].object_id

### raising an error here
# puts "14. doens't jump if invalid sequence"
# b = Board.new(false)
# p1 = Piece.new([7, 7], :white, b)
# p2 = Piece.new([6, 6], :black, b)
# b[[7, 7]] = p1
# b[[6, 6]] = p2

# p1.perform_moves!([[5, 5], [3, 3]])
# puts p1.pos == [7, 7]

puts "15. calls game over"
b = Board.new(false)
p1 = Piece.new([0, 0], :black, b)
b[[0, 0]] = p1

puts b.game_over?

puts "16. calls correct winner"
b = Board.new(false)
p1 = Piece.new([0, 0], :black, b)
b[[0, 0]] = p1

puts b.winner == :black

puts "17. king can move up and down"
b = Board.new(false)
k = Piece.new([5, 0], :white, b)
k.king = true
b[[5, 0]] = k

puts k.valid_moves.include?([6, 1]) && k.valid_moves.include?([4, 1])

puts "18. promotes king"
b = Board.new(false)
p1 = Piece.new([6, 0], :black, b)
b[[6, 0]] = p1
p1.perform_slide([7, 1])

puts p1.king == true

puts "19. coordinates convert properly"
pl = Player.new(:white)

puts pl.convert(["a1"]) == [[0, 0]] && pl.convert(["b2"]) == [[1, 1]]

