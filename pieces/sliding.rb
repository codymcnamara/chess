class Sliding < Piece


  def self.diagonals
    diagonals = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
    diagonals.map {|move| Vector.elements(move)}
  end

  def self.orthogonals
    orthogonals = [[-1, 0], [0, -1], [0, 1], [1, 0]]
    orthogonals.map {|move| Vector.elements(move)}
  end

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

  def valid?(potential_move)
    potential_move.each do |coord|
      return false unless (0..7) === coord
    end
    true
  end

end

class Queen < Sliding


  def moves
    vectors= Sliding.orthogonals + Sliding.diagonals
    super(vectors)
  end

end

class Rook < Sliding

  def moves
    vectors= Sliding.orthogonals
    super(vectors)
  end

end

class Bishop < Sliding

  def moves
    vectors = Sliding.diagonals
    super(vectors)
  end
end
