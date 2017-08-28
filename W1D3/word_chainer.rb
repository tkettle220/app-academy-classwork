require 'set'

class WordChainer

  attr_accessor :dict, :current_words, :all_seen_words

  def initialize
    @dict = IO.readlines('dict.txt').map(&:chomp).to_set
  end

  def adjacent_words(word)
    words = []
    alphabet = ("a".."z").to_a
    word.length.times do |i|
      alphabet.each do |char|
        word_dup = word.dup
        word_dup[i] = char
        unless word_dup == word
          words << word_dup if dict.include?(word_dup)
        end
      end
    end
    words
  end

  def get_dict
    @dict
  end


  def run(source, target)
    @current_words = { source => nil }
    @all_seen_words = { source => nil }

    until current_words.empty?
      new_current_words = explore_current_words(current_words, all_seen_words)
      all_seen_words.merge!(new_current_words)
      @current_words = new_current_words
      break if all_seen_words.keys.include? target
    end

    p build_path(target)
  end

  def explore_current_words(current_words, all_seen_words)
    new_current_words = {}
    current_words.keys.each do |word|
      adjacent_words(word).each do |adjacent|
        unless all_seen_words.include?(adjacent)
          new_current_words[adjacent] = word
        end
      end
    end
    new_current_words
  end

  def build_path(target)
    path = []
    parent = all_seen_words[target]
    unless all_seen_words.keys.include?(target)
      return nil
    end

    while parent
      path << parent
      parent = all_seen_words[parent]
    end

    path.reverse << target
  end

end


if $PROGRAM_NAME == __FILE__
  WordChainer.new.run(ARGV[0], ARGV[1])
end

# def is_adjacent?(word1, word2)
#   counter = 0
#   word1.chars.each_with_index do |c, i|
#     counter += 1 if c != word2[i]
#   end
#   counter == 1 ? true : false
# end
