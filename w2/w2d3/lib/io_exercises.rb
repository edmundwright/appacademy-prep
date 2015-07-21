# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  guesses = 0
  the_number = rand(100) + 1

  loop do
    puts "\nGuess a number."
    guess = gets.chomp
    guesses += 1

    if guess.to_i.to_s != guess
      puts "Invalid guess."
      guesses -= 1
    elsif guess.to_i > the_number
      puts "#{guess} is too high."
    elsif guess.to_i < the_number
      puts "#{guess} is too low"
    else
      puts "Your guess of #{guess} is correct! It took you #{guesses} guesses."
      break
    end
  end
end
