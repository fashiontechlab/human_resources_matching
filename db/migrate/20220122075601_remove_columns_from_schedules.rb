class RemoveColumnsFromSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_reference :schedules, :staff
    remove_column :schedules, :allday, :string
  end
end
