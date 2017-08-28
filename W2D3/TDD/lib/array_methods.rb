class Array

  def my_uniq
    self.inject([]) do |acc, el|
      acc.include?(el) ? acc : acc+[el]
    end
  end

  def two_sum
    (0...self.length).to_a.combination(2).to_a.select do |ind|
      self[ind.first] + self[ind.last] == 0
    end
  end

  def my_transpose
    return self if self.empty?
    raise ArgumentError.new("Cannot transpose 1D array") if self.flatten == self
    transposed_arr = Array.new(self.first.length) { Array.new }
    self.each do |row|
      row.each_with_index do |el, ind|
        transposed_arr[ind] << el
      end
    end
    transposed_arr
  end

end
