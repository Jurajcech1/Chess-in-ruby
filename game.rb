require_relative "board"
require_relative "player"

class Game
  def initialize
    @board = Board.new
    @player = Player.new(@board)
  end

  def run
    while true
      pos1 = @player.move
      pos2 = @player.move
      @board.move(pos1, pos2)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.run
end
