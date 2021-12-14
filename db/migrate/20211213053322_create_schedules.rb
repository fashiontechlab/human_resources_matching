class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :start
      t.string :end
      t.string :allday
      t.references :staff_id

      t.timestamps
    end
  end
end
