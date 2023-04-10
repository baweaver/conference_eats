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
require 'rails_helper'

RSpec.describe GatheringOutingGroup, type: :model do
  let(:accounts) do
    5.times.map { create(:account) }
  end

  subject do
    group = create(:gathering_outing_group,
      gathering_outing: create(:gathering_outing, gathering: create(:gathering))
    )

    group.accounts = accounts

    group
  end

  it 'is valid' do
    expect { subject }.to_not raise_error
  end

  describe '#full?' do
    it 'returns if the group is full' do
      expect(subject.full?).to eq(true)
    end

    context 'When the group size is unbounded' do
      it 'will never be full' do
        subject.max_size = GatheringOutingGroup::UNBOUNDED_SIZE

        expect(subject.full?).to eq(false)
      end
    end
  end

  describe '#accepting_accounts?' do
    it 'is the inversion of full' do
      expect(subject.accepting_accounts?).to eq(false)
    end

    context 'When the group size is unbounded' do
      it 'will never be full' do
        subject.max_size = GatheringOutingGroup::UNBOUNDED_SIZE

        expect(subject.accepting_accounts?).to eq(true)
      end
    end
  end

  describe '#unbounded?' do
    subject { build(:gathering_outing_group, max_size: GatheringOutingGroup::UNBOUNDED_SIZE) }

    it 'will be true if the size is unbounded' do
      expect(subject.unbounded?).to eq(true)
    end
  end
end
