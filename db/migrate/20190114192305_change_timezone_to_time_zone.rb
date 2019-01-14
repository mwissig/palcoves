class ChangeTimezoneToTimeZone < ActiveRecord::Migration[5.2]
  def change
      rename_column :users, :timezone, :time_zone
  end
end
