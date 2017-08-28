class Comment < ApplicationRecord

  validates :user_id, presence: true
  validates :artwork_id, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User,
    dependent: :destroy

  belongs_to :artwork,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: :Artwork,
    dependent: :destroy

end
