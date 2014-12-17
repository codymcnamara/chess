class Sliding < Piece

  def moves(vectors)
    potential_moves = []

    diff = 1

    loop do
      continue = false
      vectors.each do |vector|
        potential_move = position + vector * diff
        if valid?(potential_move)
          potential_moves << potential_move
          continue = true
        end
      end
      diff += 1
      break unless continue
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
