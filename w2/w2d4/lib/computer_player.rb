class ComputerPlayer
  attr_accessor :board, :mark, :name

  def initialize(name)
    @mark = :o
    @name = name
  end

  def display(board)
    @board = board
    print "#{board.to_s}\n"
  end

  def get_move
    [0,1,2].each do |row|
      [0,1,2].each do |col|
        position = [row, col]
        next if !board.empty?(position)
        @board[*position] = @mark
        is_winning_move = board.winner == @mark
        @board[*position] = nil
        return position if is_winning_move
      end
    end

    loop do
      position = [rand(3), rand(3)]
      return position if board.empty?(position)
    end
  end
end
