class Timer
  attr_accessor :seconds

  def initialize
    @seconds = 0
  end

  def self.two_digit_string(number)
    number.to_s.rjust(2,"0")
  end

  def time_string
    secs = Timer.two_digit_string(@seconds % 60)
    mins = Timer.two_digit_string((@seconds / 60) % 60)
    hrs = Timer.two_digit_string((@seconds / 60) / 60)
    "#{hrs}:#{mins}:#{secs}"
  end

end
