# == Schema Information
#
# Table name: reservations
#
#  id          :integer          not null, primary key
#  end_time    :datetime
#  start_date  :datetime
#  start_time  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ryokan_id   :integer
#  schedule_id :integer
#
# Indexes
#
#  index_reservations_on_ryokan_id    (ryokan_id)
#  index_reservations_on_schedule_id  (schedule_id)
#
class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :ryokan
end
