class AddSlugToUsernames < ActiveRecord::Migration[5.2]
  def change
    add_column :usernames, :slug, :string
  end
end
