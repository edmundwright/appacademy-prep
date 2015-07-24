require 'byebug'
class Hangman
  attr_reader :guesser, :referee, :board

  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
  end

  def setup
    @board = Array.new(@referee.pick_secret_word)
    @guesser.register_secret_length(@board.length)
    @guesses_remaining = 12
    @bad_guesses = []
  end

  def take_turn
    display_board
    puts "Guesser has #{@guesses_remaining} guesses remaining."
    puts "Bad guesses: #{@bad_guesses.join("")}\n\n"
    guess = @guesser.guess(@board)

    @guesses_remaining -= 1

    indices = @referee.check_guess(guess)

    @bad_guesses << guess.upcase if indices.empty?

    update_board(guess, indices)

    @guesser.handle_response(guess, indices)
  end

  def update_board(letter, indices)
    indices.each do |index|
      @board[index] = letter
    end
  end

  def play
    setup

    until @guesses_remaining == 0 || word_found?
      take_turn
    end

    display_board
    puts "\nGame over! Guesser #{word_found? ? "wins!" : "loses! The word was \"#{@referee.get_secret_word}\"."}"
  end

  def word_found?
    @board.none? { |letter| letter.nil? }
  end

  def display_board
    puts ""
    puts @board.map { |letter| letter.nil? ? "_" : letter.upcase }.join(" ")
    puts (0...@board.length).to_a.join(" ")
    puts ""
  end
end

class HumanPlayer
  def initialize
  end

  # Referee stuff

  def pick_secret_word
    puts "How many letters long is your secret word?"
    print "> "
    gets.chomp.to_i
  end

  def check_guess(letter)
    puts "Your opponent guessed #{letter}. In what positions does this appear? [e.g. \"0,4\", or press enter for none]"
    print "> "
    response = gets.chomp
    if response==""
      []
    else
      response.split(",").map { |string| string.to_i }
    end
  end

  def get_secret_word
    puts "What was your secret word?"
    print "> "
    gets.chomp
  end

  # Guesser stuff

  def register_secret_length(secret_length)
    puts
    puts "The secret word is #{secret_length} letters long."
  end

  def guess(current_board)
    puts "Next guess?"
    print "> "
    gets.downcase.chomp[0]
  end

  def handle_response(guess, indices)
    puts ""
    puts "The word contains #{indices.empty? ? "no" : indices.length} #{guess.upcase}#{indices.length == 1 ? "" : "s"}."
  end

end

class ComputerPlayer
  attr_reader :candidate_words

  def initialize(dictionary)
    @dictionary = dictionary.map { |word| word.chomp }
  end

  # Referee stuff

  def pick_secret_word
    @secret_word = @dictionary[rand(@dictionary.length)]
    @secret_word.length
  end

  def check_guess(letter)
    (0...@secret_word.length).select do |index|
      @secret_word[index] == letter
    end
  end

  def get_secret_word
    @secret_word
  end

  # Guesser stuff

  def register_secret_length(secret_length)
    @letters_remaining = ("a".."z").to_a
    @candidate_words = @dictionary.select { |word| word.length==secret_length }
  end

  def guess(current_board)
    choice = most_likely_remaining_letter
    choice = @letters_remaining[rand(@letters_remaining.length)] if choice.nil?
    @letters_remaining.delete(choice)
    choice
  end

  def handle_response(guess, indices)
    if indices.empty?
      @candidate_words = @candidate_words.select do |word|
        !word.each_char.include?(guess)
      end
    else
      @candidate_words = @candidate_words.select do |word|
        indices.all? { |index| word[index] == guess } &&
        indices.length == word.each_char.count(guess)
      end
    end
  end

  def most_likely_remaining_letter
    most_frequent_letter = nil

    frequencies = {}
    @candidate_words.each do |possibility|
      possibility.each_char do |letter|
        next unless @letters_remaining.include?(letter)
        frequencies[letter] = 0 if frequencies[letter].nil?
        frequencies[letter] += 1
        most_frequent_letter = letter if most_frequent_letter.nil? ||
                    frequencies[letter] > frequencies[most_frequent_letter]
      end
    end

    most_frequent_letter
  end
end
