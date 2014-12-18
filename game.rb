require_relative 'board.rb'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
    @black_player = HumanPlayer.new(:black, @board)
    @white_player = HumanPlayer.new(:white, @board)
  end

  def play
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
    begin
      puts "#{self.color} pick start position: y, x"
      start_pos = gets.chomp.split(",").map {|coord| coord.to_i}
      start_vector = Vector[start_pos[0], start_pos[1]]

      puts "pick end position: y, x"
      end_pos = gets.chomp.split(",").map {|coord| coord.to_i}
      end_vector = Vector[end_pos[0], end_pos[1]]

      @board.move(start_vector, end_vector)
    rescue
      puts "that move won't work"
      retry
    end

  end

end


g = Game.new
g.play
