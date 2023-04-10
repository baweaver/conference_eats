# == Schema Information
#
# Table name: outings
#
#  id           :bigint           not null, primary key
#  name         :string
#  start_time   :date
#  end_time     :date
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  gathering_id :string
#
require 'rails_helper'

RSpec.describe Outing, type: :model do
  let(:gathering) { create(:gathering) }

  subject do
    create(:outing, gathering:)
  end

  it 'is valid' do
    expect { subject }.to_not raise_error
  end

  describe '#default_group' do
    it 'acts as a lobby for people entering the outing' do
      expect(subject.default_group).to be_a(Group)
    end
  end

  describe "#join_lobby" do
    it 'lets an account join the default group' do
      account = create(:account)

      subject.join_lobby(account)

      expect(subject.default_group.accounts).to include(account)
    end
  end

  describe "#populate_lobby" do
    let(:accounts) { 5.times.map { create(:account) } }
    let(:gathering) { create(:gathering, accounts:) }

    it 'populates the event lobby with all accounts registered to an event' do
      subject.populate_lobby

      expect(subject.default_group.accounts.pluck(:id).sort).to eq(accounts.map(&:id).sort)
    end
  end
end
