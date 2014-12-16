require_relative './pieces.rb'

class Board
  def initialize
    @board = Array.new(8) { Array.new(8) { nil } }
    populate_board
  end

  def populate_board

  end

  def move(start, end_pos)
  end
end


# new_piece = Piece.new(2,2, Board.new)
# p new_piece


# rook = Rook.new(0,0, Board.new)
# p rook.moves
# p rook.moves.count

bishop = Bishop.new(0,0, Board.new)
p bishop.moves
p bishop.moves.count
