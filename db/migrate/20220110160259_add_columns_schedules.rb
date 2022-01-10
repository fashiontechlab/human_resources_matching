class AddColumnsSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :hope_start, :datetime
    add_column :schedules, :hope_end, :datetime
  end
end
