class AddColumnsToSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :start, :string
    remove_column :schedules, :end, :string
    add_column :schedules, :start, :datetime
    add_column :schedules, :end, :datetime
  end
end
