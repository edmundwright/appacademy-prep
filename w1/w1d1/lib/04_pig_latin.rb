VOWELS = ["a", "e", "i", "o", "u"]
LETTERS = ("a".."z")

def translate(string)
  string.split(" ").map do |word|
    new_word = ""
    ending_punctuation = ""

    (0...word.length).to_a.reverse.each do |i|
      break if LETTERS.include?(word[i].downcase)
      ending_punctuation = word[i] + ending_punctuation
    end

    (0...word.length - ending_punctuation.length).each do |i|
      if VOWELS.include?(word[i].downcase) && !(word[i].downcase=="u" && word[i-1].downcase=="q")
        new_word = word[i...word.length - ending_punctuation.length] + new_word
        break
      else
        new_word += word[i]
      end
    end

    new_word.capitalize! if word==word.capitalize

    new_word + "ay" + ending_punctuation
  end.join(" ")
end
