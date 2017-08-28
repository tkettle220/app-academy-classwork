# == Schema Information
#
# Table name: artwork_shares
#
#  id         :integer          not null, primary key
#  artwork_id :integer
#  viewer_id  :integer
#

class ArtworkShare < ApplicationRecord
  validates :viewer_id, uniqueness: { scope: :artwork_id }
  validates :viewer_id, presence: true
  validates :artwork_id, presence: true

  belongs_to :artwork,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: :Artwork

  belongs_to :viewer,
    primary_key: :id,
    foreign_key: :viewer_id,
    class_name: :User
end
