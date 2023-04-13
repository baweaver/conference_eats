require 'rails_helper'

RSpec.describe OutingPolicy do
  let(:user) { create(:account) }

  let(:gathering) { create(:gathering, accounts: [user]) }
  let(:outing) { create(:outing, gathering:) }

  let(:policy) { described_class.new(outing, user: user) }

  describe '#show?' do
    subject { policy.apply(:show?) }

    it 'can show groups to current members of the gathering the outing is in' do
      expect(subject).to eq(true)
    end

    context 'When user is not a member' do
      let(:gathering) { create(:gathering, accounts: []) }

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
    subject { policy.apply(:index?) }

    it 'has the same permissions as show' do
      expect(subject).to eq(true)
    end
  end
end
