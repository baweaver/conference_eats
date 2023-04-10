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
FactoryBot.define do
  factory :gathering_outing_group do
    gathering_outing { nil }
    name { "MyString" }
    location { "MyString" }
    max_size { 5 }
  end
end
