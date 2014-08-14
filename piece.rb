
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
    all_moves = jumping_moves(all_moves)
    all_moves
  end

  def jumping_moves(all_moves)
    all_moves.select do |pos|
      @board[pos].nil? || @board[pos].color != @color
    end
    
  end

end
