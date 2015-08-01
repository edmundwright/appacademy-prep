def measure(n=1)
  start = Time.now
  n.times {yield}
  (Time.now - start) / n
end
