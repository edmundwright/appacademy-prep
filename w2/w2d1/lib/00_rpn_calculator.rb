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

  def pop
    if @stack.empty?
      raise "calculator is empty"
    else
      @stack.pop
    end
  end

  def plus
    second_number = pop
    first_number = pop
    @stack.push(first_number + second_number)
  end

  def minus
    second_number = pop
    first_number = pop
    @stack.push(first_number - second_number)
  end

  def divide
    second_number = pop
    first_number = pop
    @stack.push(first_number / second_number.to_f)
  end

  def times
    second_number = pop
    first_number = pop
    @stack.push(first_number * second_number)
  end

  def tokens(string_of_commands)
    string_of_commands.split(" ").map do |command_string|
      if %w{+ - * /}.include?(command_string)
        command_string.to_sym
      else
        command_string.to_i
      end
    end
  end

  def evaluate(string_of_commands)
    tokens(string_of_commands).each do |command|
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

if __FILE__ == $PROGRAM_NAME
  calculator = RPNCalculator.new

  if ARGV.empty?
    
    loop do
      input = gets.chomp
      if input.empty?
        puts calculator.value
        break
      else
        calculator.evaluate(input)
      end
    end

  else

    File.foreach(ARGV[0]) do |line|
      puts calculator.evaluate(line.chomp)
    end

  end
end
