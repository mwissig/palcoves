class CreateUsernames < ActiveRecord::Migration[5.2]
  def change
    create_table :usernames do |t|
      t.integer :user_id
      t.string :username
      t.text :profile
      t.boolean :default

      t.timestamps
    end
    add_index :usernames, :username, unique: true
  end
end
