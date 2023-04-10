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

  describe "#past?" do
    it 'identifies a gathering as being in the past' do
      gathering = build(:gathering, start_date: Time.now - 1.week, end_date: Time.now - 3.days)
      expect(gathering.past?).to eq(true)
    end
  end

  describe "#current?" do
    it 'identifies a gathering as currently happening' do
      gathering = build(:gathering, start_date: Time.now - 3.days, end_date: Time.now + 3.days)
      expect(gathering.current?).to eq(true)
    end
  end

  describe "#future?" do
    it 'identifies a gathering as being in the future' do
      gathering = build(:gathering, start_date: Time.now + 1.week, end_date: Time.now + 2.weeks)
      expect(gathering.future?).to eq(true)
    end
  end

  describe 'Scopes' do
    # Scopes are expensive, and also read only. No sense in creating all this repeatedly
    before :all do
      now = Time.now

      # Past
      @past = create(:gathering, name: 'Past Event', start_date: now - 10.days, end_date: now - 1.day)

      # Current
      @current = create(:gathering, name: 'Current Event', start_date: now - 1.day, end_date: now + 1.day)

      # Future
      @future = create(:gathering, name: 'Future Event', start_date: now + 5.days, end_date: now + 10.days)
    end

    describe "#currently_running" do
      it 'gets gatherings happening currently' do
        expect(Gathering.currently_running(now: Time.now)).to include(@current)
      end
    end

    describe "#in_the_future" do
      it 'gets gatherings happening in the future' do
        expect(Gathering.in_the_future(now: Time.now)).to include(@future)
      end
    end

    describe "#in_the_past" do
      it 'gets gatherings happening in the past' do
        expect(Gathering.in_the_past(now: Time.now)).to include(@past)
      end
    end
  end
end
