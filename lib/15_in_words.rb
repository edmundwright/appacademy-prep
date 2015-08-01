class Fixnum
  def in_words
    words = {0 => 'zero', 1 => 'one', 2 => 'two', 3 => 'three', 4 => 'four',
      5 => 'five', 6 => 'six', 7 => 'seven', 8 => 'eight', 9 => 'nine',
      10 => 'ten', 11 => 'eleven', 12 => 'twelve', 13 => 'thirteen',
      14 => 'fourteen', 15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen',
      18 => 'eighteen', 19 => 'nineteen',

      20 => 'twenty', 30 => 'thirty',
      40 => 'forty', 50 => 'fifty', 60 => 'sixty', 70 => 'seventy',
      80 => 'eighty', 90 => 'ninety',

      100 => 'hundred', 1000 => "thousand",
      1_000_000 => "million", 1_000_000_000 => "billion",
      1_000_000_000_000 => "trillion"}

    big_nums = [100, 1000, 1_000_000, 1_000_000_000, 1_000_000_000_000]

    if self < 20
      words[self]
    elsif self < 100
      divisor = self / 10
      remainder = self % 10
      "#{words[10 * divisor]}#{remainder==0 ? "" : " " + remainder.in_words}"
    else
      big_nums.each_with_index do |big_num, i|
        bigger_big_num = big_nums[i+1]
        if  bigger_big_num.nil? || self < bigger_big_num
          divisor = self / big_num
          remainder = self % big_num
          return "#{divisor.in_words} #{words[big_num]}#{remainder==0 ? "" : " " + remainder.in_words}"
        end
      end
    end
  end
end
