class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :schedule, foreign_key: true
      t.references :ryokan, foreign_key: true
      t.datetime :start_date
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
