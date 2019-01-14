class CreatePms < ActiveRecord::Migration[5.2]
  def change
    create_table :pms do |t|
      t.integer :username_id
      t.text :body
      t.integer :reply_id
      t.integer :post_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
