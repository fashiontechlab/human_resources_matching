class AddDetailsToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :afternoon_start, :datetime
    add_column :schedules, :afternoon_end, :datetime
    add_column :schedules, :hope_afternoon_start, :datetime
    add_column :schedules, :hope_afternoon_end, :datetime
    add_column :schedules, :confirm_afternoon_start, :datetime
    add_column :schedules, :confirm_afternoon_end, :datetime
    add_column :schedules, :confirm_start, :datetime
    add_column :schedules, :confirm_end, :datetime
    add_column :schedules, :amount, :string
  end
end
