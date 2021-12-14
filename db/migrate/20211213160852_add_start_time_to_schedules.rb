class AddStartTimeToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :start_time, :datetime
  end
end
