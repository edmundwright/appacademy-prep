class Book
  def title
    @title
  end

  def title=(title)
    @title = Book.titleize(title)
  end

  def self.titleize(string)
    little_words = %w{the in and over of a an}

    string.split(" ").each_with_index.map do |word, index|
      if little_words.include?(word) && index!=0
        word
      else
        word.capitalize
      end
    end.join(" ")
  end
end
