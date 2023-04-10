# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  name       :string
#  company    :string
#  account_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :profile do
    name { "Someone" }
    company { "Somewhere" }
    account { nil }
  end
end
