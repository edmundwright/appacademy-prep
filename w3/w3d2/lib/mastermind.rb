class Code
  attr_reader :pegs

  PEGS = {"r" => :red, "g" => :green, "b" => :blue,
          "y" => :yellow, "o" => :orange, "p" => :purple}

  NUM_PEGS = 4

  def initialize(pegs)
    @pegs = pegs
  end

  def self.random
    pegs = []

    colors = PEGS.values

    NUM_PEGS.times do
      pegs << colors[rand(colors.length)]
    end

    new(pegs)
  end

  def self.parse(input)
    pegs = []

    input.each_char do |peg_string|
      peg = PEGS[peg_string.downcase]
      raise "Invalid peg string given." if !peg
      pegs << peg
    end

    new(pegs)
  end

  def [](index)
    @pegs[index]
  end

  def exact_matches(other_code)
    (0...NUM_PEGS).count { |index| self[index] == other_code[index] }
  end

  def near_matches(other_code)
    near_and_exact_matches = 0

    PEGS.values.each do |color|
      number_here = @pegs.count(color)
      number_there = other_code.pegs.count(color)

      if number_here > number_there
        near_and_exact_matches += number_there
      else
        near_and_exact_matches += number_here
      end
    end

    near_and_exact_matches - exact_matches(other_code)
  end

  def ==(other_code)
    exact_matches(other_code) == NUM_PEGS
  end

  def to_s
    @pegs.map { |peg| PEGS.key(peg).upcase }.join("")
  end
end

class Game
  attr_reader :secret_code

  MAX_GUESSES = 10

  def initialize(secret_code = Code.random)
    @secret_code = secret_code
    @guesses = 0
  end

  def get_guess
    appropriate_word = case @guesses
    when 0
      "First"
    when MAX_GUESSES - 1
      "Last"
    else
      "Next"
    end
    puts "#{appropriate_word} guess?"

    begin
      Code.parse(gets.chomp)
    rescue
      puts "Invalid code! Please input again."
      retry
    end
  end

  def display_matches(code)
    exact = code.exact_matches(@secret_code)
    near = code.near_matches(@secret_code)
    puts "* #{exact} exact matches, #{near} near *"
  end

  def play
    loop do
      guess = get_guess
      @guesses += 1
      if guess == @secret_code
        puts "You win! Congrats."
        break
      elsif @guesses == MAX_GUESSES
        puts "You lose! The secret code was #{@secret_code.to_s}."
        break
      else
        display_matches(guess)
      end
    end
  end
end
