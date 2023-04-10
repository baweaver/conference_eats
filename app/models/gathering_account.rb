# == Schema Information
#
# Table name: gathering_accounts
#
#  id           :bigint           not null, primary key
#  gathering_id :bigint           not null
#  blocked      :boolean
#  block_reason :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :bigint
#
class GatheringAccount < ApplicationRecord
  belongs_to :gathering
  belongs_to :account
end
