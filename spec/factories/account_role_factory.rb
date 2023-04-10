# == Schema Information
#
# Table name: account_roles
#
#  id         :bigint           not null, primary key
#  account_id :bigint           not null
#  role_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :account_role do
    account { nil }
    role { nil }
  end
end
