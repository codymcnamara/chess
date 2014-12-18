class Stepping < Piece

  def moves(vectors)
    potential_moves = []
    vectors.each do |vector|
      potential_move = position + vector
      next unless on_board?(potential_move)
      if no_piece?(potential_move) || opponent_piece?(potential_move)
        potential_moves << potential_move
      end
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

  def self.jumps
    arrays = [[-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1], [-2, 1], [-2, -1]]
    arrays.map{ |arr| Vector.elements(arr) }
  end

  def initialize(color, board, *position)
    super
    @char = @color == :black ? "♞" : "♘"
  end


  def moves
    vectors = self.class.jumps
    super(vectors)
  end
end

class Pawn < Stepping

  def self.vectors(color)
    white = [[-1, 1], [-1, -1], [-1, 0], [-2, 0]]
    black = [[1, 1], [1, -1], [1, 0], [2, 0]]
    if color == :black
      black.map{ |arr| Vector.elements(arr) }
    else
      white.map{ |arr| Vector.elements(arr) }
    end
  end


  def initialize(color, board, *position)
  super
  @char = @color == :black ? "♟" : "♙"
  end

  def moves
    potential_moves = []
    vectors = Pawn.vectors(color)
    diags = vectors.take(2)
    forwards = vectors.drop(2)
    diags.each do |vector|
      potential_move = position + vector
      next unless on_board?(potential_move) && !no_piece?(potential_move) #and not empty
      potential_moves << potential_move if opponent_piece?(potential_move)
    end
    forwards.each do |vector|
      potential_move = position + vector
      break unless on_board?(potential_move) && no_piece?(potential_move)
      potential_moves << potential_move
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
