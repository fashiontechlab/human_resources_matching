class Schedule < ApplicationRecord
  belongs_to :human_resource, class_name: "Member", foreign_key: "member_id"
  has_many :ryokan, through: :reservation
  has_many :reservation
  accepts_nested_attributes_for :reservation
end
