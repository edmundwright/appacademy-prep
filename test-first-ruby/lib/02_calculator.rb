def add(x,y)
  x + y
end

def subtract(x,y)
  x - y
end

def sum(numbers)
  result = 0
  numbers.each do |number|
    result += number
  end
  result
end

def multiply(numbers)
  result = 1  # I think; http://en.wikipedia.org/wiki/Empty_product
  numbers.each do |number|
    result *= number
  end
  result
end

def power(base,exponent)
  base ** exponent
end

def factorial(x)
  multiply((1..x)) # when x is 0, returns 1 = product of empty array
end
