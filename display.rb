require_relative 'board'
require_relative 'pieces'
require_relative 'cursorable'
require 'colorize'

class Display
  include Cursorable
  attr_reader :grid, :color
  def initialize(board)
    @board = board
    @grid = board.grid
    @cursor_pos = [0,0]
  end

  def render
    system("clear")
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |piece, col_idx|
        if [row_idx,col_idx] == @cursor_pos
          print piece_type(piece).colorize(bg = :blue)
        else
          print piece_type(piece)
        end
      end
      puts
    end
  end

  def piece_type(piece)
    if piece.nil?
      return "|_|"
    elsif piece.color == :w
      return "|♙|"
    elsif piece.color == :b
      return "|♟|"
    end
  end
end
