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
  PENDING = 'pending'

  attribute :status, default: -> { PENDING }
  attribute :status_updated_at, default: -> { Time.now }

  scope :confirmed, -> { where(status: CONFIRMED) }
  scope :declined, -> { where(status: DECLINED) }
  scope :pending, -> { where(status: PENDING) }
  scope :not_declined, -> { where.not(status: DECLINED) }

  scope :account_confirmed, -> account { where(account_id: account.id).confirmed }
  scope :account_declined, -> account { where(account_id: account.id).declined }
  scope :account_pending, -> account { where(account_id: account.id).pending }

  # Inversion
  scope :account_not_declined, -> account { where(account_id: account.id).not_declined }


  def self.account_not_in(account)
    left_joins(:account).where.not('account.id' => account.id)
  end

  def self.account_not_declined_outer(account)
    left_joins(:account).where(account_id: account.id).where.not(status: DECLINED)
  end

  def self.account_not_in_or_declined(account)
    account_not_in(account).or(account_not_declined_outer(account))
  end
end
