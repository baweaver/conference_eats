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
FactoryBot.define do
  factory :gathering_outing_group_account do
    status { 'unknown' }
    account { nil }
    gathering_outing_group { nil }
  end
end
