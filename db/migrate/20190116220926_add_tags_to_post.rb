class AddTagsToPost < ActiveRecord::Migration[5.2]
  def change
        add_column :posts, :tags, :string
  end
end
