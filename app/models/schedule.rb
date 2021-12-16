class Schedule < ApplicationRecord
  belongs_to :writer, class_name: "Member", foreign_key: "member_id"
  belongs_to :ryokan
end
