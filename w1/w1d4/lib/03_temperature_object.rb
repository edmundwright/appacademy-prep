class Temperature
  def self.ftoc(f)
    (f - 32) * 5.0 / 9
  end

  def self.ctof(c)
    (c * 9.0 / 5) + 32
  end

  def self.from_celsius(c)
    new(c: c)
  end

  def self.from_fahrenheit(f)
    new(f: f)
  end

  def initialize(options = {})
    if options.include?(:f)
      @f = options[:f]
    else
      @f = Temperature.ctof(options[:c])
    end
  end

  def in_fahrenheit
    @f
  end

  def in_celsius
    Temperature.ftoc(@f)
  end
end

class Celsius < Temperature
  def initialize(c)
    @f = Temperature.ctof(c)
  end
end

class Fahrenheit < Temperature
  def initialize(f)
    @f = f
  end
end
