class Schedule < ApplicationRecord
  belongs_to :human, class_name: "Member", foreign_key: "member_id"
end
