class Stepping < Piece

  def moves(vectors)
    potential_moves = []
    vectors.each do |vector|
      potential_move = position + vector
      potential_moves << potential_move if valid?(potential_move)
    end
    potential_moves
  end
end

class King < Stepping
  def initialize(color, board, *position)
    super
    @char = @color == :black ? "♚" : "♔"
  end

  def moves
    vectors = Piece.all_directions
    super(vectors)
  end

end

class Knight < Stepping
  def initialize(color, board, *position)
    super
    @char = @color == :black ? "♞" : "♘"
  end

  def self.jumps
    arrays = [[-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1], [-2, 1], [-2, -1]]
    arrays.map{ |arr| Vector.elements(arr) }
  end

  def moves
    vectors = self.class.jumps
    super(vectors)
  end
end

class Pawn < Stepping

  def initialize(color, board, *position)
  super
  @char = @color == :black ? "♟" : "♙"
  end

  def moves
    potential_moves = []
    case color
    when :black
      potential_moves << position + Vector[1, 0]
      potential_moves << position + Vector[2, 0] if at_start?
    when :white
      potential_moves << position + Vector[1, 0]
      potential_moves << position + Vector[2, 0] if at_start?
    end
    potential_moves
  end

  def at_start?
    case color
    when :black
      return false unless position[0] == 1
    when :white
      return false unless position[0] == 6
    end
    true
  end
end
