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
class Gathering < ApplicationRecord
  has_many :gathering_outings
  has_many :gathering_accounts
  has_many :accounts, through: :gathering_accounts

  # Should really consider localized time zones on this
  def date_range
    start_date..end_date
  end

  def coordinates
    [latitude, longitude]
  end

  def food_around
    # Call out to Yelp
  end
end
