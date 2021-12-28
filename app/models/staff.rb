# == Schema Information
#
# Table name: staffs
#
#  id              :integer          not null, primary key
#  email           :string
#  kana_name       :string
#  mobile          :integer
#  name            :string
#  password_digest :string
#  sex             :integer          default(1)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Staff < ApplicationRecord
  has_secure_password
end
