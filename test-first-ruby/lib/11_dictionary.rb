class Dictionary
  def initialize
    @entries = {}
  end

  def entries
    @entries
  end

  def add(new_entries)
    if new_entries.class==String
      @entries[new_entries] = nil
    else
      new_entries.each do |key, value|
        @entries[key] = value
      end
    end
  end

  def keywords
    @entries.keys.sort
  end

  def include?(keyword)
    @entries.keys.include?(keyword)
  end

  def find(keyword)
    @entries.select { |key,value| key.match(keyword) }
  end

  def printable
    @entries.map { |key, value| "[#{key}] \"#{value}\""}.sort.join("\n")
  end
end
