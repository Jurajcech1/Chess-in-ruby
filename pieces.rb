class Piece
  attr_reader :color
  def initialize(color=:b, board_pos = 'butt', board)
    @color = color
    @board_pos = board_pos
    @board = board
  end

  def moves
    fail "You implemented moves in Piece!"
  end
end

class SlidingPiece < Piece

end

class Bishop < SlidingPiece
  def initialize
  end
  def move_dirs
    [[1,1],[-1,-1],[-1,1],[1,-1]]
  end
end

class Rook < SlidingPiece
  def initialize
  end
  def move_dirs
    [[1,0],[-1,0],[0,1],[0,-1]]
  end
end
class Queen < SlidingPiece
  def move_dirs
    [[1,0],[-1,0],[0,1],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]
  end
end
class SteppingPiece < Piece
  def moves(current_pos, subclass)
    trans = subclass.move_dirs
    possible_moves = []
    trans.each do |tran|
      possible_moves << [tran[0] + current_pos[0],
                        tran[1] + current_pos[1]]
    end
    possible_moves = possible_moves.select do |move|
      move.all? { |x| x.between?(0,7) }
      @board[move].color != self.color
    end
    end

  end
end
class Knight < SteppingPiece
  def move_dirs
    [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
  end
end
class King < SteppingPiece
  def move_dirs
    [[1,0],[-1,0],[0,1],[0,-1],[1,1],[-1,-1],[-1,1],[1,-1]]
  end
end


end
