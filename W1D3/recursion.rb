# require 'byebug'

def range(first, last)
  return [] if last <= first
  range(first + 1, last).unshift(first)
end

def range_i(first, last)
  arr = []
  (first...last).each { |i| arr << i }
  arr
end

def recursion_1(b, n)
  return 1 if n == 0
  b * recursion_1(b, n - 1)
end

def recursion_2(b, n)
  return 1 if n == 0
  return b if n == 1
  if n % 2 == 0
    recursion_2(b, n / 2)**2
  else
    b * (recursion_2(b, (n - 1) / 2)**2)
  end
end

class Array
  def deep_dup
    arr = []
    self.each { |item| item.is_a?(Array) ? arr << item.deep_dup : arr << item }
    arr
  end
end

def fibonacci(n)
  return 1 if [1, 2].include?(n)
  return nil if n < 1
  fibonacci(n - 1) + fibonacci(n - 2)
end

def subsets(arr)
  # debugger
  return [arr] if arr.empty?
  sub1 = subsets(arr[0...-1])
  sub2 = sub1.map { |el| el.dup << arr[-1] }
  sub1 + sub2
end

def permutations(arr)
  return [arr] if arr.length == 1
  perms = []
  subperms = permutations(arr[0...-1])
  subperms.each { |a| perms.concat(insert_combination(a, arr.last)) }
  perms.uniq
end

def insert_combination(arr, value)
  answer = []
  (arr.length + 1).times do |i|
    answer << insert(arr, value, i)
  end
  answer
end

def insert(array, value, index)
  answer = []
  flag = false
  array.length.times do |n|
    if n == index
      flag = true
      answer << value
    end
    answer << array[n]
  end
  answer << value unless flag
  answer
end

def bsearch(arr, val)
  return nil if arr.length <= 0
  middle = arr.length / 2
  middle_val = arr[middle]
  if val == middle_val
    return middle
  elsif val > middle_val
    upper = bsearch(arr[middle + 1..-1], val)
    upper ? middle + 1 + upper : upper
  else
    bsearch(arr[0...middle], val)
  end
end

def merge_sort(arr)
  return arr if arr.length == 1
  middle = arr.length / 2
  merge(merge_sort(arr[0...middle]), merge_sort(arr[middle..-1]))
end

def merge(arr1, arr2)
  merged_arr = []
  until arr1.empty? && arr2.empty?
    if arr1.empty?
      merged_arr << arr2.shift
    elsif arr2.empty?
      merged_arr << arr1.shift
    elsif arr1.first < arr2.first
      merged_arr << arr1.shift
    else
      merged_arr << arr2.shift
    end
  end
  merged_arr
end

def greedy_make_change(value, coins)
  return [] if value == 0
  largest = largest_coin(value, coins)
  return nil unless largest
  greedy_make_change(value - largest, coins).unshift(largest)
end

def largest_coin(value, coins)
  answer = 0
  coins.each do |coin|
    if coin <= value && coin > answer
      answer = coin
    end
  end
  answer == 0 ? nil : answer
end

def make_better_change(value, coins)
  return [] if value == 0
  least_steps = nil
  best_coin = nil
  best_change = []
  coins.each do |coin|
    next if value - coin < 0
    possible_change = make_better_change(value - coin, coins)
    step_size = possible_change.length
    if least_steps == nil || step_size < least_steps
      least_steps = step_size
      best_coin = coin
      best_change = possible_change
    end
  end
  if best_coin == nil
    return [999]
  end
  (best_change << best_coin).sort.reverse
end
