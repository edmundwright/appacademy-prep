def measure(n=1, &proc)
  start = Time.now
  n.times { proc.call }
  (Time.now - start) / n
end
