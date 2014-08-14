
class Piece
  attr_accessor :pos, :color, :king
  def initialize(pos, color, board, king = false)
    @pos = pos
    @color = color
    @board = board
    @king = king
  end

  def perform_slide(pos_from, pos_to)

  end

  def perform_jump(pos_from, pos_to)
  end

  def promote?
  end

  def move_diffs
    return [[1, 1], [1, -1], [-1, 1], [-1, -1]] if @king
    return [[1, 1], [1, -1]] if @color == :black
    [[-1, 1], [-1, -1]]
  end

  def valid_moves
    all_moves = []
    x, y = @pos
    move_diffs.each do |diff|
      new_x = x + diff[0]
      new_y = y + diff[1]
      all_moves << [new_x, new_y] if @board.on_board?([new_x, new_y])
    end
    all_moves = remove_blocked(all_moves)
    all_moves += jump_moves
    all_moves
  end

  def jump_moves(pos = @pos)
    x, y = pos
    jump_moves = []
    move_diffs.each do |diff|
      new_pos = [x + diff[0], y + diff[1]]
      if @board.on_board?(new_pos) && !@board[new_pos].nil?
        jump_moves << jumped(new_pos, diff) unless @board[new_pos].color == @color
      end
    end
    jump_moves.compact
    jump_moves
  end

  def jumped(pos, diff)
    x, y = pos
    new_x, new_y = x + diff[0], y + diff[1]
    return [new_x, new_y] if @board.on_board?([new_x, new_y])
    nil
  end

  def remove_blocked(all_moves)
    all_moves.select do |pos|
      @board[pos].nil?
    end
  end

  def promote?
    end_pos = (@color == :black ? 7 : 0)
    @pos[0] == end_pos
  end

end
