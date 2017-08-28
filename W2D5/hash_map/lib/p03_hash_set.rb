require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(element)
    resize! if @count == num_buckets
    unless include?(element)
      @count += 1
      self[element] << element
    end
  end

  def remove(element)
    @count -= 1 if include?(element)
    self[element].delete_if do |el|
      el == element
    end
  end

  def include?(element)
    self[element].include?(element)
  end

  private

  def [](element)
    @store[element.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    temp_store = @store
    @store = new_store

    temp_store.each do |sub_arr|
      sub_arr.each do |el|
        insert(el)
        @count -= 1
      end
    end
  end
end
