require "./errors.rb"

class Piece
  attr_accessor :pos, :color, :king
  def initialize(pos, color, board, king = false)
    @pos = pos
    @color = color
    @board = board
    @king = king
  end

  def inspect
    self.color.to_s[0]
  end

  def perform_moves(move_seq)
    if valid_move_seq?(move_seq)
      perform_moves!(move_seq)
    else
      raise InvalidMoveError
    end
  end

  def valid_move_seq?(move_seq)
    dup_board = @board.dup
    piece_dup = dup_board[@pos]
    begin
      move_seq.each do |move|
        piece_dup.perform_moves!(move)
      end
      return true
    rescue InvalidMoveError => error
      puts error
      return false
    end
  end

  def perform_moves!(move_seq)
    if move_seq.length == 1 && valid_moves.include?(move_seq[0])
      perform_slide(move_seq[0])
    else
      move_seq.each do |pos_to|
        if valid_moves.include?(pos_to)
          perform_jump(pos_to)
        else
          raise InvalidMoveError
          break
        end
      end
    end
  end

  def perform_slide(pos_to, pos_from = @pos)
    self.pos = pos_to
    @board[pos_to] = self
    @king = true if promote?
    @board[pos_from] = nil
  end

  def perform_jump(pos_to, pos_from = @pos)
    self.pos = pos_to
    @board[pos_to] = self
    @king = true if promote?
    @board[pos_from] = nil
    @board.remove_enemy(pos_from, pos_to)
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
      new_pos = [x + diff[0], y + diff[1]]
      if @board.on_board?(new_pos) && @board[new_pos].nil?
        all_moves << new_pos
      end
    end
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

  def promote?
    end_pos = (@color == :black ? 7 : 0)
    @pos[0] == end_pos
  end

end
