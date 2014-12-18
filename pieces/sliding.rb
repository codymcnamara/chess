class Sliding < Piece

  def moves(vectors)
    potential_moves = []

    vectors.each do |vector|
      diff = 1
      loop do
        potential_move = position + vector * diff
        break unless on_board?(potential_move)

        if no_piece?(potential_move)
          potential_moves << potential_move
        elsif opponent_piece?(potential_move)
          potential_moves << potential_move
          break
        else
          break
        end

        diff += 1
      end
    end

    potential_moves
  end

end

class Queen < Sliding
  def initialize(color, board, *position)
    super
    @char = @color == :black ? "♛" : "♕"
  end

  def moves
    vectors = Piece.all_directions
    super(vectors)
  end

end

class Rook < Sliding

  def initialize(color, board, *position)
    super
    @char = @color == :black ? "♜" : "♖"
  end

  def moves
    vectors = Piece.orthogonals
    super(vectors)
  end

end

class Bishop < Sliding
  def initialize(color, board, *position)
    super
    @char = @color == :black ? "♝" : "♗"
  end

  def moves
    vectors = Piece.diagonals
    super(vectors)
  end
end
