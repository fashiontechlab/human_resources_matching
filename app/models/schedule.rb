class Schedule < ApplicationRecord
  belongs_to :human_resource, class_name: "Member", foreign_key: "member_id"
# belongs_to :each_inn, class_name: "Ryokan", foreign_key: "ryokan_id"
end
