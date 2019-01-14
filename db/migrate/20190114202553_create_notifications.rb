class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :type
      t.text :body
      t.integer :username_id
      t.integer :sender_id
      t.integer :post_id
      t.integer :comment_id
      t.boolean :read

      t.timestamps
    end
  end
end
