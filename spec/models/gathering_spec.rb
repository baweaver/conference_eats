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
require 'rails_helper'

RSpec.describe Gathering, type: :model do
  subject do
    build(:gathering)
  end

  it 'can be created' do
    expect { subject.save }.to_not raise_error
  end

  describe '#date_range' do
    it 'gives the date range of the event' do
      expect(subject.date_range).to include(subject.start_date + 1)
    end
  end

  describe '#coordinates' do
    it 'returns the coordinates of a location' do
      expect(build(:gathering).coordinates).to eq([0, 0])
    end
  end
end
