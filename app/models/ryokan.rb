class Ryokan < ApplicationRecord
  has_many :schedules
  belongs_to :member
  accepts_nested_attributes_for :schedules, allow_destroy: true
end
