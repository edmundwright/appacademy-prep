def translate(string)
  vowels = %w{a e i o u}
  consonants = ('a'..'z').to_a.delete_if { |i| vowels.include?(i) }

  transformed_words = string.split(" ").map do |word|
    new_word = word

    ending_punctuation = ""
    i = word.length - 1
    while i >= 0
      unless consonants.include?(word[i].downcase) || vowels.include?(word[i].downcase)
        ending_punctuation = word[i] + ending_punctuation
        i -= 1
      else
        break
      end
    end
    new_word = new_word[0..i]

    i = 0
    while i < word.length
      if word[i..i+1].downcase=="qu"
        new_word += "qu"
        i += 2
      elsif consonants.include?(word[i].downcase)
        new_word += word[i].downcase
        i += 1
      else
        break
      end
    end
    new_word = new_word[i..-1] + "ay" + ending_punctuation

    new_word[0] = new_word[0].upcase if word[0]==word[0].upcase

    new_word
  end

  transformed_words.join(" ")
end
