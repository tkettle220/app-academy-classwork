class CreateLoggedInSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :logged_in_sessions do |t|
      t.integer :user_id, null: false
      t.string :ip_address, null: false
      t.string :user_agent, null: false
    end
    add_index :logged_in_sessions, :user_id
  end
end
