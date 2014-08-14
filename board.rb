require "./piece"

class Board

  def initialize(setup = true)
    @grid = Array.new(8) { Array.new(8) }
    place_pieces if setup
  end

  def place_pieces
    # @grid.each_with_index do |row, id1|
    #   row.each_with_index do |tile, id2|
    #     next if [3, 4].include?(id1)
    #     color = (id1 < 3 ? :black : :white)
    #     if (id1 + id2).even?
    #       @grid[id1][id2] = Piece.new()
    #       #complete this
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

end

