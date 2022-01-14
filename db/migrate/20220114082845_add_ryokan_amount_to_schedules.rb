class AddRyokanAmountToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :ryokan_amount, :string
  end
end
