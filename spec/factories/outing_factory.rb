# == Schema Information
#
# Table name: outings
#
#  id           :bigint           not null, primary key
#  name         :string
#  start_time   :datetime
#  end_time     :datetime
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  gathering_id :string
#
FactoryBot.define do
  factory :outing do
    name { "MyString" }
    start_time { "2023-03-30" }
    end_time { "2023-03-30" }
    description { "MyText" }
  end
end
