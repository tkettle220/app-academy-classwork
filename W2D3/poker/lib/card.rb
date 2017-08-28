class Card
  include Comparable

  attr_reader :value, :suit


  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def <=>(other)
    @value <=> other.value
  end

end
