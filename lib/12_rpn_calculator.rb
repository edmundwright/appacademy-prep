class RPNCalculator
  def initialize
    @stack = []
  end

  def push(new_item)
    @stack << new_item
  end

  def pop
    if @stack.empty?
      raise "calculator is empty"
    else
      @stack.pop
    end
  end

  def value
    @stack.last
  end

  def plus
    @stack << pop + pop
  end

  def minus
    @stack << - (pop - pop)
  end

  def divide
    @stack << 1.0 / (pop.to_f / pop.to_f)
  end

  def times
    @stack << pop * pop
  end

  def tokens(str)
    str.split(" ").map do |item|
      if (%w{* + - /}).include?(item)
        item.to_sym
      else
        item.to_i
      end
    end
  end

  def evaluate(str)
    commands = tokens(str)
    commands.each do |command|
      if command == :+
        plus
      elsif command == :-
        minus
      elsif command == :*
        times
      elsif command == :/
        divide
      else
        push(command)
      end
    end
    value
  end

end
