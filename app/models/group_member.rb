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

  attribute :status, default: -> { UNKNOWN }
  attribute :status_updated_at, default: -> { Time.now }

  scope :confirmed, -> { where(status: CONFIRMED) }
  scope :declined, -> { where(status: DECLINED) }
  scope :unknown, -> { where(status: UNKNOWN) }
  scope :not_declined, -> { where.not(status: DECLINED) }

  scope :account_confirmed, -> account { where(account_id: account.id).confirmed }
  scope :account_declined, -> account { where(account_id: account.id).declined }
  scope :account_pending, -> account { where(account_id: account.id).unknown }

  # Inversion
  scope :account_not_declined, -> account { where.not(account_id: account.id, status: DECLINED) }
end
