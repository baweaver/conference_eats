# == Schema Information
#
# Table name: gathering_outing_group_accounts
#
#  id                        :bigint           not null, primary key
#  gathering_outing_group_id :bigint           not null
#  status                    :string
#  status_updated_at         :date
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  account_id                :bigint
#
class GatheringOutingGroupAccount < ApplicationRecord
  belongs_to :gathering_outing_group

  belongs_to :account

  scope :confirmed, -> { where(status: 'confirmed') }
  scope :declined, -> { where(status: 'declined') }
  scope :unknown, -> { where(status: 'unknown') }
end
