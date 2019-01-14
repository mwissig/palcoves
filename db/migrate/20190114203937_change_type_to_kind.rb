class ChangeTypeToKind < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :type, :kind
  end
end
