# == Schema Information
#
# Table name: gathering_members
#
#  id           :bigint           not null, primary key
#  gathering_id :bigint           not null
#  blocked      :boolean
#  block_reason :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :bigint
#
FactoryBot.define do
  factory :gathering_member do
    gathering { nil }
    account { nil }
    blocked { false }
    block_reason { "MyText" }
  end
end
