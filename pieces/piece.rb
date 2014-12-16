class Piece

  def initialize(*position, board)
    @board = board
    @position = Vector.elements(position)
  end

  private

  attr_accessor :position
end
