class AddColumnsToSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :start, :string
    remove_column :schedules, :end, :string
    remove_reference :schedules, :staff_id
    add_column :schedules, :start, :datetime
    add_column :schedules, :end, :datetime
    add_reference :schedules, :staff, foreign_key: true
  end
end
