require_relative "board"
require_relative "player"
require_relative "display"
require "byebug"
class Game
  def initialize
    @board = Board.new
    @player = Player.new(@board)
  end

  def run
    until @board.checkmate?(:w) || @board.checkmate?(:b)
      begin
        pos1 = nil
        pos2 = nil
        pos1 = @player.move
        pos2 = @player.move
        # debugger
        @board.move(pos1, pos2)
      rescue
        puts "invalid"
        sleep 1
        retry
      end
      p @board.in_check?(:w)
      p @board.in_check?(:b)
    end
    p "GAME OVER"
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.run
end
