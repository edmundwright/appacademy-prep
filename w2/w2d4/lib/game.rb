require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require 'byebug'

class Game
  attr_accessor :board, :current_player

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = Board.new
    @current_player = @player_one
  end

  def switch_players!
    if @current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end

  def play_turn
    puts "\n#{@current_player.name}'s turn!"
    the_move = @current_player.get_move
    board.place_mark(the_move, @current_player.mark)
    #debugger
    switch_players!
  end

  def play
    until board.over?
      @current_player.display(board)
      play_turn
    end

    @current_player.display(board)
    if @player_one.mark==board.winner
      puts "\n#{@player_one.name} wins!"
    else
      puts "\n#{@player_two.name} wins!"
    end
  end
end
