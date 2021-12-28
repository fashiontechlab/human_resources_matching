# == Schema Information
#
# Table name: schedules
#
#  id              :integer          not null, primary key
#  allday          :string
#  approval_status :boolean          default(FALSE), not null
#  end             :datetime
#  start           :datetime
#  start_time      :datetime
#  status          :boolean          default(TRUE), not null
#  workday         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  member_id       :integer
#  ryokan_id       :integer
#  staff_id        :integer
#
# Indexes
#
#  index_schedules_on_member_id  (member_id)
#  index_schedules_on_ryokan_id  (ryokan_id)
#  index_schedules_on_staff_id   (staff_id)
#
class Schedule < ApplicationRecord
  belongs_to :human_resource, class_name: "Member", foreign_key: "member_id"
  validates :workday, presence: true
  validates :start_time, :start, :end, presence: true
  validate :date_before_start
  validate :time_axis

  def date_before_start
    return if start_time.blank?
    errors.add(:start_time, "は本日以降を選択して下さい。") if start_time < Date.today
  end

  def time_axis
    errors.add(:end, "は出勤時間より遅い時間を選択してください。") if self.start > self.end
  end
end
