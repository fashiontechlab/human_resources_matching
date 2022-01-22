# == Schema Information
#
# Table name: entries
#
#  id         :integer          not null, primary key
#  body       :text
#  posted_at  :datetime         not null
#  status     :string           default("draft"), not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  member_id  :integer          not null
#  ryokan_id  :integer
#
# Indexes
#
#  index_entries_on_member_id  (member_id)
#  index_entries_on_ryokan_id  (ryokan_id)
#
class Entry < ApplicationRecord
  belongs_to :author, class_name: "Member", foreign_key: "member_id"
  has_many :images, class_name: "EntryImage"
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :member

  STATUS_VALUES = %w(draft member_only public)

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }

  scope :common, -> { where(status: "public") }
  scope :published, -> { where("status <> ?", "draft") }
  scope :full, ->(member) {
    where("member_id = ? OR status <> ?", member.id, "draft") }
  scope :readable_for, ->(member) { member ? full(member) : common }

  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.entry.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status] }
    end
  end
end
