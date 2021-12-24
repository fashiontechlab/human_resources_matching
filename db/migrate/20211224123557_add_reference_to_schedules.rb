class AddReferenceToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_reference :schedules, :ryokan, foreign_key: true
  end
end
