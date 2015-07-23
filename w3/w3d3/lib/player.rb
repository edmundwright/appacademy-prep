class HumanPlayer
  def initialize
  end

  def get_play(board)
    puts "Target which coordinate, sir? [e.g. \"X,Y\"]"

    gets.chomp.split(",").map { |string| string.to_i }
  end
end

class ComputerPlayer
  def initialize
  end

  def get_play(board)
    while true
      random_position = [rand(board.height), rand(board.width)]
      break unless [:o, :x].include?(board[*random_position])
    end

    random_position
  end
end
