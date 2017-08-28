class RemoveUniquenessConstraintonArtworks < ActiveRecord::Migration[5.1]
  def change
    remove_index :artworks, :artist_id
    add_index :artworks, :artist_id
  end
end
