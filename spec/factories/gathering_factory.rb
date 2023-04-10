# == Schema Information
#
# Table name: gatherings
#
#  id          :bigint           not null, primary key
#  name        :string
#  start_date  :date
#  end_date    :date
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location    :string
#  latitude    :decimal(18, 15)
#  longitude   :decimal(18, 15)
#
FactoryBot.define do
  factory :gathering do
    name { "MyString" }
    start_date { "2023-04-01" }
    end_date { "2023-04-05" }

    latitude { 0 }
    longitude { 0 }
    location { "Nowhere KS" }

    description { "Some description" }

    factory :railsconf_2023 do
      name { 'RailsConf 2023' }
      start_date { DateTime.new(2023, 04, 24) }
      end_date { DateTime.new(2023, 04, 26) }
      location { '210 Peachtree St. NW, Atlanta, Georgia, USA, 30303' }

      # Manual for now, will sort that all out later
      latitude { BigDecimal('33.75911042963162') }
      longitude { BigDecimal('-84.38828143321112') }

      description do
        <<~TEXT
          RailsConf, hosted by Ruby Central, is the world's largest and longest-running gathering of Ruby on Rails enthusiasts, practitioners, and companies.
        TEXT
      end
    end
  end
end
