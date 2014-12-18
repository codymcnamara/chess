class Piece
  attr_accessor :char, :position
  attr_reader :color, :board

  def self.diagonals
    diagonals = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
    diagonals.map {|move| Vector.elements(move)}
  end

  def self.orthogonals
    orthogonals = [[-1, 0], [0, -1], [0, 1], [1, 0]]
    orthogonals.map {|move| Vector.elements(move)}
  end

  def self.all_directions
    self.diagonals + self.orthogonals
  end

  def initialize(color, board, *position)
    @board = board

    @position = Vector.elements(position)
    @color = color
  end


  def move_into_check?(start, end_pos)
    dupped_board = Board.deep_dup(@board)
    dupped_board.move!(start, end_pos)
    dupped_board.in_check?(color) ? true : false
  end

  def inspect
    "the #{char} is at position: #{position}"
  end

  private

  def on_board?(potential_move)
    potential_move.each do |coord|
      return false unless (0..7) === coord
    end

    true
  end

  def no_piece?(potential_move)
    board[potential_move].nil?
  end

  def opponent_piece?(potential_move)
    if board[potential_move].color == color #check for own pieces
      return false
    end

    true
  end
end
