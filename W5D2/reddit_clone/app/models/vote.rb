class Vote < ApplicationRecord

  belongs_to :likeable, polymorphic: true

  belongs_to :liker,
    primary_key: :id,
    foreign_key: :liker_id,
    class_name: :User

end
