# == Schema Information
#
# Table name: schedules
#
#  id                      :integer          not null, primary key
#  afternoon_end           :datetime
#  afternoon_start         :datetime
#  allday                  :string
#  amount                  :string
#  approval_status         :boolean          default(FALSE), not null
#  confirm_afternoon_end   :datetime
#  confirm_afternoon_start :datetime
#  confirm_end             :datetime
#  confirm_start           :datetime
#  end                     :datetime
#  hope_afternoon_end      :datetime
#  hope_afternoon_start    :datetime
#  hope_end                :datetime
#  hope_start              :datetime
#  profit                  :string
#  ryokan_amount           :string
#  start                   :datetime
#  start_time              :datetime
#  status                  :boolean          default(TRUE), not null
#  work_complete_status    :boolean          default(FALSE), not null
#  workday                 :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  member_id               :integer
#  ryokan_id               :integer
#  staff_id                :integer
#
# Indexes
#
#  index_schedules_on_member_id  (member_id)
#  index_schedules_on_ryokan_id  (ryokan_id)
#  index_schedules_on_staff_id   (staff_id)
#
class Schedule < ApplicationRecord
  belongs_to :human_resource, class_name: "Member", foreign_key: "member_id"
  belongs_to :ryokan, optional: true
  validates :workday, presence: true
  validates :start_time, uniqueness: { scope: :member_id }
  validates :start, :end, presence: true
  validates :status, inclusion: { in: [true, false] }
  validates :approval_status, inclusion: { in: [true, false] }
  validate :date_before_start
  validate :time_axis, on: :check_time_axis
  validate :time_axis_hope, on: :check_time_axis_hope
  validate :time_axis_confirm, on: :check_time_axis_confirm

  scope :past_day, -> { where("schedules.start_time > ?", DateTime.now)}

  def date_before_start
    return if start_time.blank?
    errors.add(:start_time, "は明日以降を選択して下さい") if start_time < Date.today
  end

  def time_axis
    errors.add(:end, "は出勤時間より遅い時間を選択してください") if self.start > self.end || self.afternoon_start > self.afternoon_end
  end

  def time_axis_hope
    errors.add(:hope_end, "は希望出勤時間より遅い時間を選択してください") if self.hope_start > self.hope_end || self.hope_afternoon_start > self.hope_afternoon_end
  end

  def time_axis_confirm
    errors.add(:confirm_end, "は確定出勤時間より遅い時間を選択してください") if self.confirm_start > self.confirm_end || self.confirm_afternoon_start > self.confirm_afternoon_end
  end
end
