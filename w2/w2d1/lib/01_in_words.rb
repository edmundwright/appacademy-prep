class Fixnum
  def in_words
    words = {0 => "zero", 1 => "one", 2 => "two", 3 => "three",
            4 => "four", 5 => "five", 6 => "six", 7 => "seven",
            8 => "eight", 9 => "nine", 10 => "ten", 11 => "eleven",
            12 => "twelve", 13 => "thirteen", 14 => "fourteen",
            15 => "fifteen", 16 => "sixteen", 17 => "seventeen",
            18 => "eighteen", 19 => "nineteen", 20 => "twenty",
            30 => "thirty", 40 => "forty", 50 => "fifty", 60 => "sixty",
            70 => "seventy", 80 => "eighty", 90 => "ninety"}

    big_numbers = [100, 1_000, 1_000_000, 1_000_000_000,
                  1_000_000_000_000]
    big_number_words = {100 => "hundred", 1_000 => "thousand",
                        1_000_000 => "million",
                        1_000_000_000 => "billion",
                        1_000_000_000_000 => "trillion"}

    if words.include?(self)
      words[self]
    elsif self < 100
      tens_string = words[(self / 10) * 10]
      units_string = words[self % 10]
      "#{tens_string} #{units_string}"
    else
      big_numbers.each_with_index do |big_number, i|
        if big_numbers[i+1].nil? || self < big_numbers[i+1]
          big_number_string = "#{(self / big_number).in_words}" +
                               " #{big_number_words[big_number]}"
          remainder = self % big_number
          if remainder==0
            remainder_string = ""
          else
            remainder_string = " #{(self % big_number).in_words}"
          end
          return "#{big_number_string}#{remainder_string}"
        end
      end
    end
  end
end
