def reverser
  words_reversed = yield.split(" ").map { |word| word.reverse }
  words_reversed.join(" ")
end

def adder(to_add = 1)
  yield + to_add
end

def repeater(n = 1)
  n.times {yield}
end
