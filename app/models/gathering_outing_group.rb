# == Schema Information
#
# Table name: gathering_outing_groups
#
#  id                  :bigint           not null, primary key
#  gathering_outing_id :bigint           not null
#  name                :string
#  location            :string
#  max_size            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class GatheringOutingGroup < ApplicationRecord
  belongs_to :gathering_outing

  has_many :gathering_outing_group_accounts
  has_many :accounts, through: :gathering_outing_group_accounts

  scope :with_members, -> { joins(:gathering_outing_group_accounts) }

  scope :confirmed_accounts, -> { with_members.merge(GatheringOutingGroupAccount.confirmed) }
  scope :declined_accounts, -> { with_members.merge(GatheringOutingGroupAccount.declined) }
  scope :unknown_accounts, -> { with_members.merge(GatheringOutingGroupAccount.unknown) }

  UNBOUNDED_SIZE = -1

  def full?
    !unbounded? || gathering_outing_group_accounts.confirmed.count == max_size
  end

  def accepting_accounts?
    unbounded? || !full?
  end

  def unbounded?
    max_size == UNBOUNDED_SIZE
  end
end
