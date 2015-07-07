def echo(x)
  x
end

def shout(x)
  x.upcase
end

def repeat(word, num_times = 2)
  ([word] * num_times).join(" ")
end

def start_of_word(word, num_chars)
  word[0...num_chars]
end

def first_word(str)
  str.split(" ")[0]
end

def titleize(str)
  little_words = %w{a an and as at but by en for if in nor of on or per the to
                    vs over}

  transformed_words = str.split(" ").each_with_index.map do |word, index|
    if little_words.include?(word) && index!=0
      word
    else
      word.capitalize
    end
  end

  transformed_words.join(" ")
end
