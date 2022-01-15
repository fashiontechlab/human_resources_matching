class AddProfitToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :profit, :string
  end
end
