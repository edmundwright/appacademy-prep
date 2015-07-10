def add(x,y)
  x + y
end

def subtract(x,y)
  x - y
end

def sum(numbers)
  numbers.inject(0) { |sum_so_far, next_number| sum_so_far + next_number }
end

def multiply(numbers)
  numbers.inject(1) { |prod_so_far, next_number| prod_so_far * next_number }
end

def power(x,y)
  x ** y
end

def factorial(x)
  return 1 if x==0
  x * factorial(x - 1)
end