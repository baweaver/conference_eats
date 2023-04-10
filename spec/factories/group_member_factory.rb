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
FactoryBot.define do
  factory :group_member do
    status { 'unknown' }
    account { nil }
    group { nil }
  end
end
