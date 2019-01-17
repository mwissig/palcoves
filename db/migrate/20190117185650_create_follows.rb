class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :username_id
      t.text :body
      t.integer :recipient_id
      t.string :tag

      t.timestamps
    end
  end
end
