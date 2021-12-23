class Ryokan < ApplicationRecord
  has_secure_password

  has_many :schedule, through: :reservation
  has_many :reservation
end
