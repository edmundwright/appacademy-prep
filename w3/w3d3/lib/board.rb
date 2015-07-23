class Board
  attr_reader :grid, :height, :width

  def initialize(grid = Board.default_grid)
    @grid = grid
    @height = grid.length
    @width = grid[0].length
  end

  def self.build_size(height, width)
    Board.new(Array.new(height) { Array.new(width) })
  end

  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

  def count
    @grid.inject(0) do |acc, row|
      acc + row.count { |cell| cell == :s}
    end
  end

  def empty?(pos = nil)
    if pos
      self[*pos] != :s
    else
      count == 0
    end
  end

  def full?
    count == @height * @width
  end

  def place_random_ship
    raise "Board is full!" if full?
    loop do
      random_position = [rand(@height), rand(@width)]
      if empty?(random_position)
        self[*random_position] = :s
        break
      end
    end
  end

  def populate_grid
    (@height * @width / 5).times { place_random_ship }
  end

  def won?
    empty?
  end

  def display
    cell_strings = {:s => " ", nil => " ", :o => "X", :x => "~"}

    print "  "
    print (0...@width).to_a.inject("") { |acc, num| "#{acc}  #{num} "}
    print "\n"
    @grid.each_with_index do |row, index|
      print "  #{"+---" * @width}+\n#{index} "
      print row.inject("") { |acc, cell| "#{acc}| #{cell_strings[cell]} " }
      print "|\n"
    end
    print "  #{"+---" * @width}+\n"
  end
end
