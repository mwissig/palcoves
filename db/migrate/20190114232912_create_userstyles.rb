class CreateUserstyles < ActiveRecord::Migration[5.2]
  def change
    create_table :userstyles do |t|
      t.integer :username_id
      t.string :post_background_color
      t.string :post_text_color
      t.string :page_background_color

      t.timestamps
    end
  end
end
