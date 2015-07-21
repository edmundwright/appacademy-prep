class HumanPlayer
  attr_accessor :name, :mark

  def initialize(name)
    @mark = :x
    @name = name
  end

  def display(board)
    print "#{board.to_s}\n"
  end

  def get_move
    puts "\nWhere?"
    gets.chomp.split(",").map { |num| num.to_i }
  end
end
