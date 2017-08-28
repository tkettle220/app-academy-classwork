class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
    self
  end

  def my_select(&prc)
    arr = []
    my_each { |n| arr.push(n) if prc.call(n) }
    arr
  end

  def my_reject(&prc)
    arr = []
    my_each { |n| arr.push(n) unless prc.call(n) }
    arr
  end

  def my_any?(&prc)
    flag = false
    my_each { |n| flag = true if prc.call(n) }
    flag
  end

  def my_all?(&prc)
    flag = true
    my_each { |n| flag = false unless prc.call(n) }
    flag
  end

  def my_flatten
    flat_arr = []
    each do |el|
      if el.is_a?(Array)
        el.my_flatten.each do |el2|
          flat_arr << el2
        end
      else
        flat_arr << el
      end
    end
    flat_arr
  end

  def my_zip(*args)
    len = self.length
    arr = Array.new

    (0...len).each do |i|
      arr << my_zip_helper(i, *args)
    end

    arr
  end

  def my_zip_helper(i, *args)
    arr = []
    arr << self[i]
    args.each do |sub_arr|
      arr << sub_arr[i]
    end
    arr
  end

  def my_rotate(n=1)
    if n < 0
      n.abs.times do
        self.unshift(self.pop)
      end
    else
      n.times do
        self.push(self.shift)
      end
    end
    self
  end

  def my_join(seperator = "")
    result_str = ""
    each_with_index do |el, i|
      result_str << el
      result_str << seperator unless i == self.length - 1
    end
    result_str
  end

  def my_reverse
    result_arr = []
    self.length.times do 
      result_arr.push(self.pop)
    end
    result_arr
  end



end
