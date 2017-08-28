class CreateArtwork < ActiveRecord::Migration[5.1]
  def change
    create_table :artworks do |t|
      t.string :title, presence: true
      t.string :image_ur, presence: true
      t.integer :artist_id, presence: true
    end
  end
end
