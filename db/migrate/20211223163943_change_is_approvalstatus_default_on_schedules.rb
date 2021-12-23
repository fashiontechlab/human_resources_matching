class ChangeIsApprovalstatusDefaultOnSchedules < ActiveRecord::Migration[5.2]
  def change
    change_column_default :schedules, :approval_status, from: true, to: false
  end
end
