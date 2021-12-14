class AddWorkdayToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :workday, :string
  end
end
