class RPNCalculator
  def initialize
    @stack = []
  end

  def push(new_num)
    @stack.push(new_num)
  end

  def value
    @stack.last
  end

  def plus
    second_number = @stack.pop
    first_number = @stack.pop
    @stack.push(first_number + second_number)
  end

  def minus
    second_number = @stack.pop
    first_number = @stack.pop
    @stack.push(first_number - second_number)
  end

  def divide
    second_number = @stack.pop
    first_number = @stack.pop
    @stack.push(first_number / second_number.to_f)
  end

  def times
    second_number = @stack.pop
    first_number = @stack.pop
    @stack.push(first_number * second_number)
  end
end
