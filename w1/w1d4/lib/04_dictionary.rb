class Dictionary
  attr_accessor :entries

  def initialize
    @entries = {}
  end

  def add(new_entries)
    if new_entries.is_a?(Hash)
      new_entries.each do |key, value|
        @entries[key] = value
      end
    else
      @entries[new_entries] = nil
    end
  end

  def keywords
    @entries.keys.sort
  end

  def include?(keyword)
    @entries.include?(keyword)
  end

  def find(keyword)
    @entries.select { |key, value| key.include?(keyword)}
  end

  def printable
    sorted_entries = @entries.sort { |(k1, v1), (k2, v2)| k1 <=> k2}
    sorted_entries.map { |key, value| "[#{key}] \"#{value}\""}.join("\n")
  end
end
