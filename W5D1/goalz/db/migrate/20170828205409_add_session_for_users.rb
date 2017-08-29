class AddSessionForUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :session, :string
  end
end
