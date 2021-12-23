class AddApprovalStatusToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :approval_status, :boolean, default: true, null: false
  end
end
