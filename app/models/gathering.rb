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
  has_many :outings
  has_many :gathering_members
  has_many :accounts, through: :gathering_members

  validates :start_date, comparison: { less_than: :end_date }

  def self.in_the_future(now: Time.now)
    where('start_date >= ?', now)
  end

  def self.currently_running(now: Time.now)
    where('start_date <= ? AND end_date >= ?', now, now)
  end

  def self.in_the_past(now: Time.now)
    where('end_date <= ?', now)
  end

  def future?
    start_date >= Time.now
  end

  def past?
    Time.now > end_date
  end

  def current?
    date_range.cover?(Time.now)
  end

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
