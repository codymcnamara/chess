require_relative 'requirements.rb'
require 'byebug'

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) { nil } }
    populate_board
  end

  def populate_board
    create_pawns
    create_rear_rows
  end

  def create_pawns
    [[:black, 1], [:white, 6]].each do |(color, y)|
      (0..7).each do |x|
        @board[y][x] = Pawn.new(color, self, y, x)
      end
    end
  end

  def create_rear_rows
    [[:black, 0], [:white, 7]].each do |(color, y)|
      [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].each_with_index do |clazz, x|
        @board[y][x] = clazz.new(color, self, y, x)
      end
    end
  end

  def render
    @board.each do |row|
      row.each do |piece|
        if piece
          print piece.char
        else
          print "_"
        end
        print " "
      end
      puts
    end
  end

  def move(start, end_pos)
  end
end


# new_piece = Piece.new(2,2, Board.new)
# p new_piece


# rook = Rook.new(0,0, Board.new)
# p rook.moves
# p rook.moves.count

# knight = King.new(0,0, Board.new)
# p knight.moves
# p knight.moves.count

b = Board.new
b.render


p b.board[1][3].moves
