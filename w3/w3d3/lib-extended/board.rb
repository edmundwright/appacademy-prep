class Board
  attr_reader :grid, :height, :width, :ships

  def initialize(height = 5, width = 5)
    @height = height
    @width = width
    @grid = Array.new(height) { Array.new(width) }
    @ships = []
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

  def room_for_ship?(ship)
    (0...@height).each do |i|
      (0...@width).each do |j|
        start_position = [i,j]
        [true, false].each do |is_horizontal|
          duplicate_ship = ship.dup
          duplicate_ship.place(is_horizontal, start_position)
          return true if ship_in_ok_position?(duplicate_ship)
        end
      end
    end

    false
  end

  def ship_in_ok_position?(ship)
    ship.sections.each do |section|
      return false if !in_grid?(section.position) || !self[*section.position].nil?
    end

    true
  end

  def in_grid?(pos)
    pos[0] >= 0 && pos[0] < @height && pos[1] >= 0 && pos[1] < @width
  end

  def delete_all_ships
    @ships = []
    (0...@height).each do |i|
      (0...@width).each do |j|
        self[i,j] = nil
      end
    end
  end

  def add_ship(ship)
    @ships << ship
    update_grid
  end

  def destroy_at_position(pos)
    no_ship_at_position = true

    @ships.each do |ship|
      ship.sections.each do |section|
        if section.position == pos
          section.destroy
          self[*pos] = :x
          no_ship_at_position = false
        end
      end
    end

    self[*pos] = :o if no_ship_at_position
  end

  def update_grid
    @ships.each do |ship|
      ship.sections.each do |section|
        if section.is_destroyed
          self[*section.position] = :x
        else
          self[*section.position] = :s
        end
      end
    end
  end

  def display(options = {:everything_is_visible => false})
    cell_strings = {:s => " ", nil => " ", :o => "~", :x => "X"}
    cell_strings[:s] = "S" if options[:everything_is_visible]

    update_grid

    print "  "
    print (0...@width).to_a.inject("") { |acc, num| "#{acc}  #{num} "}
    print "\n"
    @grid.each_with_index do |row, index|
      print "  #{"+---" * @width}+\n#{index} "
      print row.inject("") { |acc, cell| "#{acc}| #{cell_strings[cell]} " }
      print "|\n"
    end
    print "  #{"+---" * @width}+\n\n"
  end
end
