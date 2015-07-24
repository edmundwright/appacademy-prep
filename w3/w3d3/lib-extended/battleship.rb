require_relative "board"
require_relative "player"
require_relative "ship"
require "byebug"

class BattleshipGame
  def initialize(options = {})
    defaults = {player1: HumanPlayer.new(Board.new),
                player2: ComputerPlayer.new(Board.new)}
    options = defaults.merge(options)
    @player1 = options[:player1]
    @player2 = options[:player2]
  end

  def self.quick_play(height = 5, width = 5)
    new(player1: HumanPlayer.new(Board.new(height, width)),
        player2: ComputerPlayer.new(Board.new(height, width))).play
  end

  def game_over?
    @player1.lost? || @player2.lost?
  end

  def play_turn
    @player2.board.destroy_at_position(@player1.get_play(@player2.board))
    @player1.board.destroy_at_position(@player2.get_play(@player1.board))
  end

  def display_status
    print "\n" * 20
    puts "* #{@player1.player_type.upcase} PLAYER 1'S BOARD *"
    @player1.board.display(everything_is_visible: true)
    puts "Ships remaining: #{@player1.ship_names_remaining.join(", ")}"
    puts "\n"
    puts "* #{@player2.player_type.upcase} PLAYER 2'S BOARD *"
    @player2.board.display
    puts "Ships remaining: #{@player2.ship_names_remaining.join(", ")}"
  end

  def play
    [@player1, @player2].each do |player|
      player.place_ships
    end

    until game_over?
      display_status
      play_turn
    end

    display_status
    puts "\n* Game over! *"
    if @player1.lost?
      if @player2.lost?
        puts "Draw!"
      else
        puts "Player 2 (#{@player2.player_type}) wins!"
      end
    else
      puts "Player 1 (#{@player1.player_type}) wins!"
    end
  end
end
