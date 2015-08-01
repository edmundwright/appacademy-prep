class Book
  def initialize
    @title = nil
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

  def title=(new_title)
    @title = titleize(new_title)
  end

  def title
    @title
  end
end
