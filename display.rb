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

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      if piece != nil
        piece.to_s.colorize(color_options)
      else
        '   '.to_s.colorize(color_options)
      end

    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :black
    elsif (i + j).odd?
      bg = :green
    else
      bg = :white
    end
    { background: bg, color: :red }
  end


  def render
    system("clear")
    build_grid.each { |row| puts row.join('') }
    # @grid.each_with_index do |row, row_idx|
    #   row.each_with_index do |piece, col_idx|
    #     if [row_idx,col_idx] == @cursor_pos
    #       print piece_type(piece).colorize(bg = :blue)
    #     else
    #       print piece_type(piece)
    #     end
    #   end
    #   puts
    # end
  end
end
