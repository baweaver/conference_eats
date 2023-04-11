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
  let(:outing) { create(:outing, gathering:) }

  subject do
    outing # Yeah yeah, will fix later
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

  describe '#assign_to_group' do
    context 'When an open group exists' do
      let(:known_open_group) { create(:group, outing: subject, max_size: 2) }

      before do
        known_open_group.assign_to_group(create(:account))
      end

      it 'assigns the account to the open group' do
        expect {
          subject.assign_to_group(create(:account))
        }.to change {
          known_open_group.group_members.count
        }.by(1)
      end
    end

    context 'When no open groups exist' do
      let(:known_full_group) { create(:group, outing: subject, max_size: 2) }

      before do
        known_full_group.assign_to_group(create(:account))
        known_full_group.assign_to_group(create(:account))
      end

      it 'assigns the account to the open group' do
        expect(known_full_group.group_members.count).to eq(2)

        expect {
          subject.assign_to_group(create(:account))
        }.to change {
          Group.count
        }.by(1)

        expect(known_full_group.group_members.count).to eq(2)
      end
    end
  end

  describe '#open_groups' do
    context 'When only the lobby is open' do
      it 'does not show the lobby as "open"' do
        # Generate the lobby
        subject.default_group

        expect(subject.open_groups).to be_empty
      end
    end

    context 'When there is an open group' do
      let(:known_open_group) { create(:group, outing: subject, max_size: 2) }

      before do
        known_open_group.assign_to_group(create(:account))
      end

      it 'will show the open group' do
        expect(subject.open_groups).to include(known_open_group)
      end
    end

    context 'When there is a full group' do
      let(:known_full_group) { create(:group, outing: subject, max_size: 2) }

      before do
        known_full_group.assign_to_group(create(:account))
        known_full_group.assign_to_group(create(:account))
      end

      it 'will not show the full group' do
        expect(subject.open_groups).to_not include(known_full_group)
      end
    end
  end

  describe '#full_groups' do
    context 'When only the lobby is open' do
      it 'does not show the lobby as "open"' do
        # Generate the lobby
        subject.default_group

        expect(subject.full_groups).to be_empty
      end
    end

    context 'When there is an open group' do
      let(:known_open_group) { create(:group, outing: subject, max_size: 2) }

      before do
        known_open_group.assign_to_group(create(:account))
      end

      it 'will not show the open group' do
        expect(subject.full_groups).to_not include(known_open_group)
      end
    end

    context 'When there is a full group' do
      let(:known_full_group) { create(:group, outing: subject, max_size: 2) }

      before do
        known_full_group.assign_to_group(create(:account))
        known_full_group.assign_to_group(create(:account))
      end

      it 'will show the full group' do
        expect(subject.full_groups).to include(known_full_group)
      end
    end
  end
end
