class Piece
  attr_accessor :char, :position
  attr_reader :color

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

  def inspect
    "the #{char} is at position: #{position}"
  end

  private

  def valid?(potential_move)
    potential_move.each do |coord|
      return false unless (0..7) === coord
    end
    true
  end
end
