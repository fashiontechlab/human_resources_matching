class AddReferencesToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_reference :schedules, :member, foreign_key: true
  end
end
