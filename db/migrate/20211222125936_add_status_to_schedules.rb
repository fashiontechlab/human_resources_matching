class AddStatusToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :status, :boolean, default: true, null: false
  end
end
