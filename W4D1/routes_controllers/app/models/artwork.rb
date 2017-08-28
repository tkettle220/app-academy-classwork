# == Schema Information
#
# Table name: artworks
#
#  id        :integer          not null, primary key
#  title     :string
#  image_ur  :string
#  artist_id :integer
#

class Artwork < ApplicationRecord
  validates :title, uniqueness: { scope: :artist_id }

  belongs_to :artist,
    primary_key: :id,
    foreign_key: :artist_id,
    class_name: :User

  has_many :artwork_shares,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: :ArtworkShare

  has_many :shared_viewers,
    through: :artwork_shares,
    source: :viewer

  has_many :comments,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: :Comment

  has_many :commenters,
    through: :comments,
    source: :author
end
