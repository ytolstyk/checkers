# encoding: UTF-8
require "./piece"

class Board
  DISPLAY_HASH = {
    nil => "_",
    :black => "X",
    :white => "O"
  }

  def initialize(setup = true)
    @grid = Array.new(8) { Array.new(8) }
    place_pieces if setup
  end

  def place_pieces
    @grid.each_with_index do |row, id1|
      row.each_with_index do |tile, id2|
        next if [3, 4].include?(id1)
        color = (id1 < 3 ? :black : :white)
        if (id1 + id2).even?
          @grid[id1][id2] = Piece.new([id1, id2], color, self)
        end
      end
    end
  end

  def display
    print "  | 1  2  3  4  5  6  7  8"
    puts
    puts  "--------------------------"

    @grid.each_with_index do |row, id|
      print "#{(id + "a".ord).chr} |"
      row.each do |tile|
        if tile.nil?
          print " _ "
        else
          print " #{DISPLAY_HASH[tile.color]} "
        end
      end
      puts
    end
    puts  "--------------------------"
  end

  def remove_enemy(pos_from, pos_to)
    remove_x = (pos_from[0] + pos_to[0]) / 2
    remove_y = (pos_from[1] + pos_to[1]) / 2
    self[[remove_x, remove_y]] = nil
  end

  def on_board?(pos)
    pos.all? { |i| i.between?(0, 7) }
  end

  def empty?(pos)
    self[pos].nil?
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def pieces
    @grid.flatten.compact
  end

  def dup
    dup_board = Board.new(false)
    pieces.each do |piece|
      dup_board.place_piece(piece.pos.dup, piece.color, piece.king)
    end
    dup_board
  end

  def game_over?
    pieces.none? {|piece| piece.color == :black} ||
      pieces.none? {|piece| piece.color == :white}
  end

  def winner
    return "nobody" unless game_over?
    return :black if pieces.any? {|piece| piece.color == :black}
    :white
  end

  def place_piece(pos, color, king)
    self[pos] = Piece.new(pos, color, self, king)
  end

end

