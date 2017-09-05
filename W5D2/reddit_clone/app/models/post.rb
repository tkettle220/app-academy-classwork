class Post < ApplicationRecord
  include Likeable


  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :PostSub

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :Comment


end
