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
#  telephone       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Ryokan < ApplicationRecord
  has_secure_password
  has_one :schedule
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, email: { allow_blank: false }
  validates :full_name, presence:true, length: { maximum: 15 }
  validates :kana_name, presence:true, length: { maximum: 15 }
  validates :manager, presence:true, length: { maximum: 15 }
  validates :name, presence:true, length: { minimum: 2, maximum: 15, allow_blank: true}

  attr_accessor :current_ryokan_password
  validates :password, presence: { if: :current_ryokan_password }
end
