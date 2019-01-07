class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :username_id
      t.text :body
      t.integer :reply_id
      t.integer :post_id
      t.boolean :shared
      t.boolean :private
      t.integer :recipient_id

      t.timestamps
    end
  end
end
