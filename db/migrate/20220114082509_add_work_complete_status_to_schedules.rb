class AddWorkCompleteStatusToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :work_complete_status, :boolean, default: false, null: false
  end
end
