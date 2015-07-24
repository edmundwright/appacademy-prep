class Ship
  attr_accessor :sections, :name, :length

  LENGTHS = {:carrier => 5, :battleship => 4, :submarine => 3,
             :destroyer => 3, :patrol => 2}
  NAMES = {:carrier => "Aircraft Carrier", :battleship => "Battleship",
           :submarine => "Submarine", :destroyer => "Destroyer",
           :patrol => "Patrol Boat"}

  def initialize(type)
    @name = NAMES[type]
    @length = LENGTHS[type]
  end

  def place(is_horizontal, start_position)
    @sections = []
    (0...@length).each do |index|
      if is_horizontal
        @sections << Section.new([start_position[0], start_position[1] + index])
      else
        @sections << Section.new([start_position[0] + index, start_position[1]])
      end
    end
  end

  def unplace
    @sections = []
  end

  def Ship.types
    LENGTHS.keys
  end

  def destroyed?
    @sections.all? { |section| section.is_destroyed }
  end
end

class Section
  attr_reader :position, :is_destroyed

  def initialize(position)
    @destroyed = false
    @position = position
  end

  def destroy
    @is_destroyed = true
  end
end
