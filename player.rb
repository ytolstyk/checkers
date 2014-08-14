#require "./error.rb"

class Player
  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def turn(board)
    @board = board
    begin
      move_seq = validate_seq(prompt)
      return true if move_seq == "quit"
      move_seq = convert(move_seq)
      valid_piece(move_seq[0])
      piece = move_seq.shift
      @board[piece].perform_moves(move_seq)
    rescue InvalidMoveError => error
      puts error
      retry
    rescue InvalidCoordinates => error
      puts error
      retry
    rescue InvalidPiece => error
      puts error
      retry
    rescue InvalidMoveError => error
      puts error
      retry
    end

    false
  end

  def valid_piece(piece)
    raise InvalidPiece if @board.empty?(piece)
    raise InvalidPiece unless @color == @board[piece].color
  end

  def convert(move_seq)
    zero = "a".ord
    move_seq.map do |pos|
      [pos[0].ord % zero, pos[1].to_i - 1]
    end
  end

  def validate_seq(move_seq)
    return "quit" if move_seq[0] == "quit"
    move_seq.each do |pos|
      unless pos[0].ord.between?("a".ord, "h".ord) &&
             pos[1..-1].to_i.between?(1, 8)
        raise InvalidCoordinates
      end
    end
  end

end

class HumanPlayer < Player
  def prompt
    puts "#{@color.to_s.capitalize}: input a piece place followed by a sequence of moves"
    answer = gets.chomp.downcase.split
    answer
  end
end