# == Schema Information
#
# Table name: group_members
#
#  id                :bigint           not null, primary key
#  group_id          :bigint           not null
#  status            :string
#  status_updated_at :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :bigint
#
class GroupMember < ApplicationRecord
  belongs_to :group
  belongs_to :account

  CONFIRMED = 'confirmed'
  DECLINED = 'declined'
  UNKNOWN = 'unknown'

  scope :confirmed, -> { where(status: CONFIRMED) }
  scope :declined, -> { where(status: DECLINED) }
  scope :unknown, -> { where(status: UNKNOWN) }
  scope :not_declined, -> { where.not(status: DECLINED) }
end
