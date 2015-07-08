def echo(speech)
  speech
end

def shout(speech)
  speech.upcase
end

def repeat(speech, times = 2)
  ([speech] * times).join(" ")
end

def start_of_word(word, length)
  word[0, length]
end

def first_word(string)
  string.split(" ")[0]
end


def titleize(string)
  little_words = %w{the in and over}
  
  string.split(" ").each_with_index.map do |word, index|
    if little_words.include?(word) && index!=0
      word
    else
      word.capitalize
    end
  end.join(" ")
end