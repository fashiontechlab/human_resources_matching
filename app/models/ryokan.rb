# == Schema Information
#
# Table name: ryokans
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  full_name       :string           not null
#  kana_name       :string
#  manager         :string           not null
#  name            :string           not null
#  password_digest :string
#  telephone       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Ryokan < ApplicationRecord
  has_secure_password
end
