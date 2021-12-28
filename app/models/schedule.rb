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
end
