require_relative 'board.rb'
require 'byebug'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
    @black_player = HumanPlayer.new(:black, @board)
    @white_player = HumanPlayer.new(:white, @board)
  end

  def play
    @board.render

    while true
      @white_player.play_turn

      @board.render
      if @board.checkmate?(:black)
        puts "white wins!"
        break
      end

      @black_player.play_turn
      @board.render
      if @board.checkmate?(:white)
        puts "black wins!"
        break
      end

    end
  end

end



class HumanPlayer
  attr_reader :color

  def initialize(color, board)
    @color = color
    @board = board
  end


  def play_turn
    letters = ("a".."h").to_a

    begin
      puts "#{self.color} pick start position. example: b2"
      start_input = gets.chomp.split("")
      start_x_pos = letters.index(start_input[0])
      start_y_pos = (start_input[1].to_i - 8).abs
      start_vector = Vector[start_y_pos, start_x_pos]

      puts "pick end position. example: b3"
      end_input = gets.chomp.split("")
      end_x_pos = letters.index(end_input[0])
      end_y_pos = (end_input[1].to_i - 8).abs
      end_vector = Vector[end_y_pos, end_x_pos]

      @board.move(start_vector, end_vector)
    rescue
      puts "that move won't work"
      retry
    end

  end

end


g = Game.new
g.play
