class Temperature
  def initialize(options = {})
    if options[:c]
      @celsius = options[:c]
    elsif options[:f]
      @celsius = Temperature.ftoc(options[:f])
    end
  end

  def self.from_celsius(celsius)
    self.new(:c => celsius)
  end

  def self.from_fahrenheit(fahrenheit)
    self.new(:f => fahrenheit)
  end

  def self.ftoc(f)
    (f - 32) * 5.0 / 9
  end

  def self.ctof(c)
    (c * 9.0 / 5) + 32
  end

  def in_celsius
    @celsius
  end

  def in_fahrenheit
    Temperature.ctof(@celsius)
  end
end

class Celsius < Temperature
  def initialize(celsius)
    @celsius = celsius
  end
end

class Fahrenheit < Temperature
  def initialize(farhenheit)
    @celsius = Temperature.ftoc(farhenheit)
  end
end
