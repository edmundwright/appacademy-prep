class Timer
  attr_accessor :seconds

  def initialize
    @seconds = 0
  end

  def padded(number)
    number.to_s.rjust(2,"0")
  end

  def time_string
    secs = @seconds % 60
    hrs = (@seconds / 60) / 60
    mins = (@seconds / 60) % 60
    "#{padded(hrs)}:#{padded(mins)}:#{padded(secs)}"
  end
end
