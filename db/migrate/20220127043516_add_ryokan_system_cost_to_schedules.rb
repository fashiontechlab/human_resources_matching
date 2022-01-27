class AddRyokanSystemCostToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :system_cost, :string
  end
end
