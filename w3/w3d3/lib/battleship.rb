require_relative "board"
require_relative "player"

class BattleshipGame
  attr_reader :board, :player

  def initialize(player = HumanPlayer.new, board = Board.new)
    @player = player
    @board = board
    board.populate_grid
  end

  def attack(pos)
    if board[*pos] == :s
      board[*pos] = :o
    else
      board[*pos] = :x
    end
  end

  def count
    board.count
  end

  def game_over?
    board.won?
  end

  def play_turn
    attack(player.get_play(board))
  end

  def display_status
    board.display
    puts "Ships remaining: #{board.count}"
  end

  def play
    until game_over?
      display_status
      play_turn
    end

    display_status
    puts "Game over!"
  end
end
