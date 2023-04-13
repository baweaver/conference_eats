require 'rails_helper'

RSpec.describe GatheringPolicy do
  let(:user) { create(:account) }

  let(:gathering) { create(:gathering, accounts: [user]) }

  let(:policy) { described_class.new(gathering, user: user) }

  describe '#show?' do
    subject { policy.apply(:show?) }

    it 'can show a gathering if the user is a member' do
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
    let(:gathering) { build(:gathering) }

    subject { policy.apply(:index?) }

    it 'can be viewed by logged in users' do
      expect(subject).to eq(true)
    end

    context 'When the user is not logged in' do
      let(:user) { nil }

      it 'fails' do
        expect(subject).to eq(false)
      end
    end
  end
end
