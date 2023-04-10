# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  outing_id  :bigint           not null
#  name       :string
#  location   :string
#  max_size   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :group do
    outing { nil }
    name { "MyString" }
    location { "MyString" }
    max_size { 5 }
  end
end
