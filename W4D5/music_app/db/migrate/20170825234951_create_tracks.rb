class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.string :song_name
      t.integer :length

      t.timestamps
    end
  end
end
