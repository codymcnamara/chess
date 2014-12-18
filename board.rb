require_relative 'requirements.rb'
require 'byebug'

class Board
  def self.deep_dup(old_board)
    new_board = Board.new(false)
    old_board.grid.flatten.compact.each do |piece|
      pos = piece.position.dup
      new_board[piece.position] = piece.class.new(piece.color, new_board, pos[0], pos[1])
    end

    new_board
  end

  attr_accessor :grid

  def initialize(populate = true)
    @grid = Array.new(8) { Array.new(8) { nil } }
    populate_board if populate
  end

  def populate_board
    create_pawns
    create_rear_rows
  end

  def create_pawns
    [[:black, 1], [:white, 6]].each do |(color, y)|
      (0..7).each do |x|
        @grid[y][x] = Pawn.new(color, self, y, x)
      end
    end
  end

  def create_rear_rows
    [[:black, 0], [:white, 7]].each do |(color, y)|
      [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].each_with_index do |clazz, x|
        @grid[y][x] = clazz.new(color, self, y, x)
      end
    end
  end

  def move(start, end_pos)
    raise "in check!" if self[start].move_into_check?(start, end_pos)

    raise "Invalid Move" unless self[start].moves.include?(end_pos)
    self[end_pos] = self[start] #changes the grid
    self[start] = nil #start position becomes empty square
    self[end_pos].position = end_pos #tells piece it's new position
    true
  end

  def move!(start, end_pos)
    self[end_pos] = self[start] #changes the grid
    self[start] = nil #start position becomes empty square
    self[end_pos].position = end_pos #tells piece it's new position
  end

  def in_check?(color)
    king = find_king(color)
    opponents_pieces(color).each do |opponent|
      return true if opponent.moves.include?(king.position)
    end

    false
  end

  def opponents_pieces(color)
    grid.flatten.compact.select { |piece| piece.color != color }
  end

  def my_pieces(color)
    grid.flatten.compact.select { |piece| piece.color == color }
  end

  def find_king(color)
    king = nil
    grid.flatten.compact.each do |piece|
      king = piece if piece.is_a?(King) && piece.color == color
    end
    king
  end

  def checkmate?(color)
    return false unless in_check?(color)
    my_pieces(color).each do |piece|
      initial_pos = piece.position
      piece.moves.each do |potential_move|
        return false if piece.move_into_check?(initial_pos, potential_move) == false
      end
    end

    true
  end

  def [](vector)
    grid[vector[0]][vector[1]]
  end

  def []=(vector, value)
    grid[vector[0]][vector[1]] = value
  end

  def render
    @grid.each do |row|
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
    nil
  end
end


# a = Board.new
# a.move(Vector[1,4], Vector[3,4])
# a.move(Vector[6,5], Vector[5,5])
# a.move(Vector[6,6], Vector[4,6])
# a.move(Vector[0,3], Vector[4,7])
# a.render
# p a.checkmate?(:white)
#p Board.deep_dup(a)[Vector[6,2]].moves
