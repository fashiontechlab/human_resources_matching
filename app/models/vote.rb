# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  entry_id   :integer          not null
#  member_id  :integer          not null
#
# Indexes
#
#  index_votes_on_entry_id   (entry_id)
#  index_votes_on_member_id  (member_id)
#
class Vote < ApplicationRecord
  belongs_to :entry
  belongs_to :member

  validate do
    unless member && member.votable_for?(entry)
      errors.add(:base, :invalid)
    end
  end
end
