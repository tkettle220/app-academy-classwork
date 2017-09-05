class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :value
      t.integer :likeable_id
      t.string :likeable_type
      t.integer :liker_id
      t.timestamps
    end
    add_index :votes, :likeable_id
    add_index :votes, :liker_id
    add_index :votes, [:likeable_id, :liker_id, :likeable_type], unique: true
  end
end
