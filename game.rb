require "./board.rb"
require "./player.rb"

class Game

  def initialize(player1 = HumanPlayer, player2 = HumanPlayer, board = Board)
    @board = board.new
    @player1 = player1.new(:white)
    @player2 = player2.new(:black)
  end

  def play
    until game_over
      players.each do |player|
        @board.display
        player.turn(@board)
        break if game_over
      end
    end
    puts "#{@board.winner.to_s.capitalize} won!"
  end

  def game_over
    @board.game_over?
  end

  def players
    [@player1, @player2]
  end

end