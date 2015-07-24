class Maze
  attr_reader :end, :paths, :start

  def initialize(file_name)
    @rows = File.readlines(file_name).map { |row| row.chomp.split("") }
    @height = @rows.length
    @width = @rows[0].length
    @end = find_cell_containing("E")
    @start = find_cell_containing("S")
    @paths = {@end => []}
  end

  def display
    @rows.each do |row|
      puts row.join("")
    end
  end

  def [](i, j)
    @rows[i][j]
  end

  def in_grid?(pos)
    pos[0] >= 0 && pos[0] < @height && pos[1] >= 0 && pos[1] < @width
  end

  def clear?(pos)
    self[*pos] != "*"
  end

  def find_cell_containing(contents)
    (0...@height).each do |i|
      (0...@width).each do |j|
        return [i,j] if self[i,j] == contents
      end
    end
  end

  def find_paths_to_end
    find_paths_to_pos(@end)
  end

  def find_paths_to_pos(pos)
    travelable_neighbours(pos).each do |neighbour|
      if @paths[neighbour].nil? || @paths[neighbour].length > @paths[pos].length + 1
        @paths[neighbour] = @paths[pos] + [pos]
        find_paths_to_pos(neighbour)
      end
    end
  end

  def solve
    find_paths_to_end
    display_path_from(@start)
  end

  def display_path_from(start_pos)
    (0...@height).each do |i|
      (0...@width).each do |j|
        if @paths[start_pos].include?([i,j]) && @end != [i,j]
          print "X"
        else
          print self[i,j]
        end
      end
      print "\n"
    end
  end

  def travelable_neighbours(pos)
    neighbours = [ [pos[0]    , pos[1] + 1],
                   [pos[0]    , pos[1] - 1],
                   [pos[0] + 1, pos[1]    ],
                   [pos[0] - 1, pos[1]    ] ]
    neighbours.select { |next_step| in_grid?(next_step) && clear?(next_step) }
  end
end

if __FILE__ == $PROGRAM_NAME
  maze = Maze.new(ARGV[0])
  maze.solve
end
