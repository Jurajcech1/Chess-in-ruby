require_relative 'pieces'
require_relative 'display'
require_relative 'player'
require 'colorize'

class Board
  def initialize
    @grid = populate_grid
  end

  attr_reader :grid

  def populate_grid
    [Array.new(8) {Piece.new(:w)},
    Array.new(8) {Piece.new(:w)},
    Array.new(8) {nil},
    Array.new(8) {nil},
    Array.new(8) {nil},
    Array.new(8) {nil},
    Array.new(8) {Piece.new},
    Array.new(8) {Piece.new}]
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]] = value
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0,7) }
  end


  def move(start, end_pos)
    if (self[start] == nil) || !in_bounds?(end_pos)
      fail "That's an invalid move!"
    else
      piece = self[start]
      self[end_pos] = piece
      self[start] = nil
    end
  end
end

if __FILE__ == $PROGRAM_NAME

  b = Board.new
  d = Display.new(b)
  player = Player.new(b)
  player.move
end
