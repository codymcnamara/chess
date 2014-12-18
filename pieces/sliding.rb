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


  # potential_moves = []
  #
  # diff = 1
  #
  # while vectors.any?
  #   new_vectors = vectors
  #   vectors.each do |vector|
  #     potential_move = position + vector * diff
  #     unless on_board?(potential_move)
  #       new_vectors = vectors - [vector]
  #       next
  #     end
  #
  #     unless (board.square(potential_move) && board.square(potential_move).color == color)
  #       new_vectors = vectors - [vector]
  #       next
  #     end
  #     potential_moves << potential_move
  #   end
  #   diff += 1
  #   vectors = new_vectors
  # end
  #
  # potential_moves
  # end
  def valid_moves(thing)

  end

  # def valid_moves(vectors)
  #   legal_moves = []
  #
  #   potential_moves = moves(vectors)
  #   potential_moves.each |potential_move|
  #   if board.square(potential_move) == nil
  #     legal_moves << potential_move
  #   elsif board.square(potential_move).color ==
  #
  #   end
  #
  # end
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
