class Player
  attr_reader :player_type, :board

  def lost?
    ships_remaining.empty?
  end

  def ships_remaining
    @board.ships.select { |ship| !ship.destroyed? }
  end

  def ship_names_remaining
    ships_remaining.map { |ship| ship.name }
  end
end

class HumanPlayer < Player
  def initialize(board)
    @player_type = "Human"
    @board = board
  end

  def place_ships
    Ship.types.each do |type|
      new_ship = Ship.new(type)
      if @board.room_for_ship?(new_ship)
        place_ship(new_ship)
      else
        puts "\n\nOh dear sir, you didn't think this through - there's no room for"
        puts "the next ship! Let's just start again from the beginning...\n\n"
        @board.delete_all_ships
        place_ships
        return
      end
    end
  end

  def place_ship(ship)
    @board.display(everything_is_visible: true)
    puts "Where shall we place the #{ship.name} (length: #{ship.length}), sir?"
    puts "Orientation? [\"h\" = horizontal, \"v\" = vertical]"

    is_horizontal = gets.chomp.downcase == "h"

    if is_horizontal
      puts "Position of its left-most section? [e.g. \"X,Y\"]"
    else
      puts "Position of its top-most section? [e.g. \"X,Y\"]"
    end

    start_position = get_pos_from_string(gets.chomp)

    ship.place(is_horizontal, start_position)

    if @board.ship_in_ok_position?(ship)
      @board.add_ship(ship)
    else
      ship.unplace
      puts "\n\nI'm sorry sir, but the ship won't fit there! Have another go?\n\n"
      place_ship(ship)
    end
  end

  def get_play(board)
    puts "\n* Target which coordinate, sir? [e.g. \"X,Y\"]"
    get_pos_from_string(gets.chomp)
  end

  def get_pos_from_string(string)
    string.split(",").map { |string| string.to_i }
  end
end

class ComputerPlayer < Player
  def initialize(board)
    @player_type = "Computer"
    @board = board
  end

  def place_ships
    failed = false

    loop do
      Ship.types.each do |type|
        new_ship = Ship.new(type)
        if @board.room_for_ship?(new_ship)
          place_ship(new_ship)
        else
          @board.delete_all_ships
          failed = true
        end
      end

      break unless failed
    end
  end

  def place_ship(ship)
    loop do
      start_position = [rand(@board.height), rand(@board.width)]
      is_horizontal = rand(2) == 1

      ship.place(is_horizontal, start_position)

      if @board.ship_in_ok_position?(ship)
        @board.add_ship(ship)
        break
      else
        ship.unplace
      end
    end
  end

  def get_play(board)
    while true
      random_position = [rand(board.height), rand(board.width)]
      break unless [:o, :x].include?(board[*random_position])
    end

    random_position
  end
end
