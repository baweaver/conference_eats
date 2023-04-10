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
require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:accounts) do
    5.times.map { create(:account) }
  end

  subject do
    group = create(:group,
      outing: create(:outing, gathering: create(:gathering))
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
        subject.max_size = Group::UNBOUNDED_SIZE

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
        subject.max_size = Group::UNBOUNDED_SIZE

        expect(subject.accepting_accounts?).to eq(true)
      end
    end
  end

  describe '#unbounded?' do
    subject { build(:group, max_size: Group::UNBOUNDED_SIZE) }

    it 'will be true if the size is unbounded' do
      expect(subject.unbounded?).to eq(true)
    end
  end
end
