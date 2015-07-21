class Board
  attr_reader :grid

  def initialize(grid = Array.new(3) { Array.new(3) })
    @grid = grid
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, new_entry)
    @grid[row][col] = new_entry
  end

  def empty?(position)
    self[*position].nil?
  end

  def place_mark(position, mark)
    raise "Position not empty!" if !empty?(position)
    self[*position] = mark
  end

  def winner
    [0, 1, 2].each do |i|
      return self[i,0] if self[i,0] && self[i,0]==self[i,1] && self[i,0]==self[i,2]
      return self[0,i] if self[0,i] && self[0,i]==self[1,i] && self[0,i]==self[2,i]
    end
    return self[0,0] if self[0,0] && self[0,0]==self[1,1] && self[0,0]==self[2,2]
    return self[2,0] if self[2,0] && self[2,0]==self[1,1] && self[2,0]==self[0,2]

    nil
  end

  def over?
    winner || @grid.none? { |row| row.any? { |el| el.nil? }}
  end

  def to_s
    @grid.map do |row|
      row.map do |element|
        if element.nil?
          "_"
        else
          element.to_s
        end
      end.join(" ")
    end.join("\n")
  end
end
