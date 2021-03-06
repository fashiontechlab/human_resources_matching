# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  administrator   :boolean          default(FALSE), not null
#  email           :string
#  full_name       :string
#  kana_name       :string
#  mobile          :string
#  name            :string           not null
#  password_digest :string
#  sex             :integer          default(1), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Member < ApplicationRecord
  has_secure_password

  has_many :entries, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :voted_entries, through: :votes, source: :entry
  has_many :schedules, dependent: :destroy
  has_one_attached :profile_picture

  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean
  validates :name, presence: true,
    format: { with: /\A[A-Za-z]\w*\z/, allow_blank: true },
    length: { minimum: 2, maximum: 20, allow_blank: true },
    uniqueness: { case_sensitive: false }
  validates :full_name, presence:true, length: { maximum: 20 }
  validates :kana_name, presence:true, length: { maximum: 20 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  attr_accessor :current_password
  validates :password, presence: { if: :current_password }

  validate do
    if new_profile_picture
      if new_profile_picture.respond_to?(:content_type)
        unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
          errors.add(:new_profile_picture, :invalid_image_type)
        end
      else
        errors.add(:new_profile_picture, :invalid)
      end
    end
  end

  before_save do
    if new_profile_picture
      self.profile_picture = new_profile_picture
    elsif remove_profile_picture
      self.profile_picture.purge
    end
  end

  def votable_for?(entry)
    entry && entry.author != self && !votes.exists?(entry_id: entry.id)
  end

  class << self
    def search(query)
      rel = order("name")
      if query.present?
        rel = rel.where("name LIKE ? OR full_name LIKE ?",
                        "%#{query}%", "%#{query}%")
      end
      rel
    end
  end
end


