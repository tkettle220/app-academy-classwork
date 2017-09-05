module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :votes,
    as: :likeable,
    class_name: :Vote,
    dependent: :destroy
  end

  def num_votes
    self.votes.sum(:value)
  end

end
