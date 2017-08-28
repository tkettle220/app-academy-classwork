class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    num = 1
    self.each_with_index do |el, i|
      unless el.is_a?(Fixnum)
        el = el.hash
      end
      case i % 4
      when 0
        num += el
      when 1
        num *= el
      when 2
        num -= el
      when 3
        num += 256 if el == 0
        num /= el
      end
    end
    num.hash
  end
end

class String
  def hash
    num = 752
    num_arr = self.chars.map(&:ord)
    num_arr.each_with_index do |el, i|
      case i % 4
      when 0
        num += el
      when 1
        num *= el
      when 2
        num -= el
      when 3
        num += 256 if el == 0
        num /= el
      end
    end
    num.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    num = -74
    self.each do |key, val|
      val = val.to_s if val.is_a?(Symbol)
      key = key.to_s if key.is_a?(Symbol)
      num -= key.hash
    end
    num.hash
  end
end

class Symbol
  def hash
    self.to_s.hash
  end
end
