class Piece
  attr_reader :color, :board_pos
  attr_accessor :board_pos
  def initialize(color, board_pos, board)
    @color, @board_pos, @board = color, board_pos, board
  end

  def teammate?(pos)
    (@board[pos] != nil && @board[pos].color == self.color)
  end

  def enemy?(pos)
    @board[pos] != nil && @board[pos].color != self.color
  end

  def moves
    fail "You implemented moves in Piece!"
  end

  def valid_moves
    vm = moves.reject do |move|
      dup_board = @board.deep_dup
      dup_board.move!(@board_pos, move)
      dup_board.in_check?(@color)
    end
    a = { :k => self.class, :m => moves, :vm => vm }
    p a
    vm
  end
end
require 'byebug'
class SlidingPiece < Piece
  def moves
    possible_moves = []
    self.move_dirs.each do |move_dir|

      new_pos = [move_dir[0] + @board_pos[0], move_dir[1] + @board_pos[1]]
      while @board.in_bounds?(new_pos) && @board[new_pos] == nil

        possible_moves << new_pos
        new_pos = [move_dir[0] + new_pos[0], move_dir[1] + new_pos[1]]
      end

      if @board.in_bounds?(new_pos) && (@board[new_pos].color != self.color)
        possible_moves << new_pos
      end
    end
    possible_moves
  end
end

class Bishop < SlidingPiece

  def move_dirs
    [[1,1],[-1,-1],[-1,1],[1,-1]]
  end

  def to_s
    if @color == :b
      ' ♝ '
    else
      ' ♗ '
    end
  end
end

class Rook < SlidingPiece

  def move_dirs
    [[1,0],[-1,0],[0,1],[0,-1]]
  end

  def to_s
    if @color == :b
      ' ♜ '
    else
      ' ♖ '
    end
  end
end

class Queen < SlidingPiece

  def move_dirs
    [[1,0],[-1,0],[0,1],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]
  end

  def to_s
    if @color == :b
      ' ♛ '
    else
      ' ♕ '
    end
  end
end

class SteppingPiece < Piece

  def moves
    possible_moves = []
    move_dirs.each do |move_dir|
      possible_moves << [move_dir[0] + @board_pos[0],
                        move_dir[1] + @board_pos[1]]
    end
    possible_moves.select do |move|
      @board.in_bounds?(move) && !teammate?(move)
    end
  end
end

class Knight < SteppingPiece

  def move_dirs
    [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
  end

  def to_s
    if @color == :b
      ' ♞ '
    else
      ' ♘ '
    end
  end
end

class King < SteppingPiece

  def move_dirs
    [[1,0],[-1,0],[0,1],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]
  end

  def to_s
    if @color == :b
      ' ♚ '
    else
      ' ♔ '
    end
  end
end
require 'byebug'
class Pawn < Piece

  def moves
    possible_moves = []
    move_dirs.each do |move_dir|
      possible_moves << [move_dir[0] + @board_pos[0],
                        move_dir[1] + @board_pos[1]]
    end
    possible_moves.select do |move|
      @board.in_bounds?(move) && !teammate?(move)
    end
  end

  def move_dirs
    dirs = nil
    if @color == :b
      move_down = [@board_pos[0] + 1,@board_pos[1]]
      if enemy?(move_down)
        dirs = [[]]
      else
        dirs = [[1,0]]
      end
      move_down2 = [@board_pos[0] + 2,@board_pos[1]]
      if @board_pos[0] == 1 && !enemy?(move_down2) && !enemy?(move_down)
        dirs << [2,0]
      end
      left_pos = [@board_pos[0] + 1, @board_pos[1] - 1]
      right_pos = [@board_pos[0] + 1, @board_pos[1] + 1]
      if @board[left_pos] != nil && @board[left_pos].color == :w
        dirs << left_pos
      end
      if @board[right_pos] != nil && @board[right_pos].color == :w
        dirs << right_pos
      end

    elsif @color == :w
      move_up = [@board_pos[0] - 1,@board_pos[1]]
      if enemy?(move_up)
        dirs = [[]]
      else
        dirs = [[-1,0]]
      end

      move_up2 = [@board_pos[0] - 2,@board_pos[1]]
      if @board_pos[0] == 6 && !enemy?(move_up2) && !enemy?(move_up)
        dirs << [-2,0]
      end
      left_pos = [@board_pos[0] - 1, @board_pos[1] - 1]
      right_pos = [@board_pos[0] - 1, @board_pos[1] + 1]
      if @board[left_pos] != nil && @board[left_pos].color == :b
        dirs << left_pos
      end
      if @board[right_pos] != nil && @board[right_pos].color == :b
        dirs << right_pos
      end
    end
    dirs
  end

  def to_s
    if @color == :b
      ' ♟ '
    else
      ' ♙ '
    end
  end
end
