require_relative 'pieces'
require_relative 'display'
require_relative 'player'
require 'colorize'

class Board
  def initialize(flag = false)
    if flag == true
      @grid = Array.new(8) {Array.new(8)}
    else
      @grid = populate_grid
    end
  end

  attr_accessor :grid

  def populate_grid
    #color=:b, board_pos = nil, board
    board = [[Rook.new(:b,[0,0],self), Knight.new(:b,[0,1],self), #ROW 1
    Bishop.new(:b,[0,2],self), Queen.new(:b, [0,3],self), King.new(:b, [0,4],self),
    Bishop.new(:b, [0,5],self), Knight.new(:b, [0,6],self), Rook.new(:b, [0,7],self)],

    [Pawn.new(:b,[1,0],self),Pawn.new(:b,[1,1],self),Pawn.new(:b,[1,2],self), #ROW2
    Pawn.new(:b,[1,3],self),Pawn.new(:b,[1,4],self),Pawn.new(:b,[1,5],self),
    Pawn.new(:b,[1,6],self),Pawn.new(:b,[1,7],self)],

    Array.new(8) {nil}, #ROW3
    Array.new(8) {nil}, #ROW4
    Array.new(8) {nil}, #ROW5
    Array.new(8) {nil}, #ROW6

    [Pawn.new(:w,[6,0],self),Pawn.new(:w,[6,1],self),Pawn.new(:w,[6,2],self), #ROW7
    Pawn.new(:w,[6,3],self),Pawn.new(:w,[6,4],self),Pawn.new(:w,[6,5],self),
    Pawn.new(:w,[6,6],self),Pawn.new(:w,[6,7],self)],

    [Rook.new(:w,[7,0],self), Knight.new(:w,[7,1],self), #ROW8
    Bishop.new(:w,[7,2],self), Queen.new(:w, [7,3],self), King.new(:w, [7,4],self),
    Bishop.new(:w, [7,5],self), Knight.new(:w, [7,6],self), Rook.new(:w, [7,7],self)]]
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

  def in_check?(color)
    king_pos = nil
    @grid.flatten.each do |piece|
      if piece.is_a?(King) && piece.color == color
        king_pos = piece.board_pos
      end
    end

    @grid.each_with_index do |row, row_i|
      row.each_with_index do |col, col_i|
        pos = [row_i, col_i]
        piece = self[pos]
        if piece != nil && piece.color != color
          if piece.moves.include?(king_pos)
            return true
          end
        end
      end
    end
    false
  end

  def checkmate?(color)
    #if the player is in checkmate
    #none of the player's pieces have any valid moves
    if in_check?(color)
      @grid.flatten.each do |piece|
        if piece != nil && piece.color == color
          return false unless piece.valid_moves.empty?
        end
      end
    else
      return false
    end
    true
  end

  def deep_dup
    new_board = Board.new(true)
    @grid.flatten.each do |square|

        next if square == nil

        new_color = square.color
        new_board_pos = square.board_pos.dup
        board = new_board

        new_board[new_board_pos] = square.class.new(new_color, new_board_pos, board)
    end
    new_board
  end

  def move(start, end_pos)
    if (self[start] == nil) || !in_bounds?(end_pos) || !self[start].valid_moves.include?(end_pos)
      fail "That's an invalid move!"
    else
      move!(start, end_pos)
    end
  end

  def move!(start, end_pos)
    piece = self[start]
    piece.board_pos = end_pos
    self[end_pos] = piece
    self[start] = nil unless start == end_pos
  end
end

if __FILE__ == $PROGRAM_NAME

  b = Board.new
  d = Display.new(b)
  player = Player.new(b)
end
