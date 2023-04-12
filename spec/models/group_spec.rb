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

  describe 'Scopes' do
    let_it_be(:gathering) { create(:gathering) }
    let_it_be(:outing) { create(:outing, name: 'Group Size Test', gathering:) }
    let_it_be(:accounts) { 5.times.map { create(:account, email: "#{_1}@test.com") } }

    let_it_be(:declined_account) { accounts[3] }

    let_it_be(:lobby_group) do
      create(:group, name: 'Lobby', max_size: -1, accounts:, outing:)
    end

    let_it_be(:full_group) do
      create(:group, name: 'Full', max_size: 2, accounts: accounts.first(2), outing:)
    end

    let_it_be(:not_full_group) do
      create(:group, name: 'Not Full', max_size: 2, accounts: accounts.last(1), outing:)
    end

    let_it_be(:not_full_group_with_decline) do
      group = create(:group, name: 'Not Full Declined', max_size: 2, accounts: [declined_account], outing:)
      group.group_members.first.update(status: 'declined')
      group
    end

    describe '.full' do
      it 'returns groups which are full' do
        full_groups = Group.full

        expect(full_groups).to include(full_group)
        expect(full_groups).not_to include(not_full_group, not_full_group_with_decline, lobby_group)
      end
    end

    describe '.not_full' do
      it 'returns groups which are not full' do
        not_full_groups = Group.not_full

        expect(not_full_groups).not_to include(full_group, lobby_group)
        expect(not_full_groups).to include(not_full_group, not_full_group_with_decline)
      end
    end

    describe '.not_declined_by' do
      it 'will only show groups not declined by the account' do
        not_declined_groups = Group.not_declined_by(declined_account)

        expect(not_declined_groups).to_not include(not_full_group_with_decline)
        expect(not_declined_groups).to include(full_group, not_full_group, lobby_group)
      end
    end

    describe '.excluding_lobby' do
      it 'does not return unbounded sized groups' do
        not_lobby_groups = Group.excluding_lobby

        expect(not_lobby_groups).to include(full_group, not_full_group, not_full_group_with_decline)
        expect(not_lobby_groups).not_to include(lobby_group)
      end
    end
  end
end
