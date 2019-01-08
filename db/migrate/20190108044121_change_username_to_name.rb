class ChangeUsernameToName < ActiveRecord::Migration[5.2]
  def change
        rename_column :usernames, :username, :name
  end
end
