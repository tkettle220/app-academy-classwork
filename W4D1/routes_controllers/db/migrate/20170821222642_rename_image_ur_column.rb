class RenameImageUrColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :artworks, :image_ur, :image_url

  end
end
