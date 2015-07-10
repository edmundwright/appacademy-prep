def reverser(&proc)
  proc.call.split(" ").map { |word| word.reverse }.join(" ")
end

def adder(to_add = 1, &proc)
  proc.call + to_add
end

def repeater(n = 1, &proc)
  n.times { proc.call }
end
