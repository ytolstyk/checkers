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
      move_seq = convert(move_seq)
      valid_piece(move_seq[0])
    rescue InvalidMoveError => error
      puts error
      retry
    rescue InvalidCoordinates => error
      puts error
      retry
    rescue InvalidPiece => error
      puts error
      retry
    end
    #call perform_moves here move_seq
  end

  def valid_piece(piece)
    raise InvalidPiece unless @color == @board[piece].color
  end

  def convert(move_seq)
    zero = "a".ord
    move_seq.map do |pos|
      [pos[0].ord % zero, pos[1].to_i - 1]
    end
  end

  def validate_seq(move_seq)
    move_seq.each do |pos|
      unless pos[0].to_i.between?("a".ord, "h".ord) &&
             pos[1].to_i.between?(1, 8)
        raise InvalidCoordinates
      end
    end
  end

  def prompt
    puts "Input a piece place followed by a sequence of moves."
    gets.chomp.split
  end


end

class HumanPlayer < Player

end