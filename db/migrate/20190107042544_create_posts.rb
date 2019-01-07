class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :username_id
      t.string :title
      t.text :body
      t.integer :op_id
      t.text :share_comment
      t.boolean :archive
      t.boolean :gallery

      t.timestamps
    end
  end
end
