require 'rails_helper'

RSpec.describe GroupPolicy do
  let_it_be(:user) { create(:account) }

  let_it_be(:gathering) { create(:gathering) }
  let_it_be(:outing) { create(:outing, gathering:) }
  let_it_be(:group) { create(:group, accounts: [user], outing:) }

  let(:policy) { described_class.new(group, user: user) }

  describe '#show?' do
    subject { policy.apply(:show?) }

    it 'can show groups to current members' do
      expect(subject).to eq(true)
    end

    context 'When user is not a member' do
      let(:group) { create(:group, outing:) }

      it 'fails' do
        expect(subject).to eq(false)
      end
    end

    context 'When user declined' do
      let(:group) do
        create(:group, accounts: [user], outing:).tap do |group|
          group.group_members.first.update(status: 'declined')
        end
      end

      it 'fails' do
        expect(subject).to eq(false)
      end
    end

    context 'When user is an admin' do
      let(:user) { create(:account).tap { _1.roles << create(:role, name: 'admin')} }

      it 'passes' do
        expect(subject).to eq(true)
      end
    end
  end

  describe '#index?' do
    let(:user) { create(:account).tap { _1.roles << create(:role, name: 'admin')} }
    subject { policy.apply(:index?) }

    it 'can be seen by the admin' do
      expect(subject).to eq(true)
    end
  end
end
