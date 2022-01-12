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
#  start                   :datetime
#  start_time              :datetime
#  status                  :boolean          default(TRUE), not null
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
  validates :start_time, :start, :end, presence: true
  validates :status, inclusion: { in: [true, false] }
  validates :approval_status, inclusion: { in: [true, false] }
  validate :date_before_start
  validate :time_axis
  validate :time_axis_afternoon
#  validate :time_axis_hope
#  validate :time_axis_hope_afternoon
#  validate :time_axis_confirm
#  validate :time_axis_confirm_afternoon

  private

  def date_before_start
    return if start_time.blank?
    errors.add(:start_time, "は明日以降を選択して下さい") if start_time < Date.today
  end

  def time_axis
    errors.add(:end, "は出勤時間より遅い時間を選択してください") if self.start > self.end
  end

  def time_axis_afternoon
    errors.add(:afternoon_end, "は出勤時間より遅い時間を選択してください") if self.afternoon_start > self.afternoon_end
  end

#  def time_axis_hope
#    errors.add(:hope_end, "は希望出勤時間より遅い時間を選択してください") if self.hope_start > self.hope_end
#  end
#
#  def time_axis_hope_afternoon
#    errors.add(:hope_afternoon_end, "は希望出勤時間より遅い時間を選択してください") if self.hope_afternoon_start > self.hope_afternoon_end
#  end
#
#  def time_axis_confirm
#    errors.add(:confirm_end, "は確定出勤時間より遅い時間を選択してください") if self.confirm_start > self.confirm_end
#  end
#
#  def time_axis_confirm_afternoon
#    errors.add(:confirm_afternoon_end, "は確定出勤時間より遅い時間を選択してください") if self.confirm_afternoon_start > self.confirm_afternoon_end
#  end

  scope :past_day, -> { where("schedules.start_time > ?", DateTime.now)}
end
