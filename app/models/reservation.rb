class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :ryokan
end
