# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string
#  company    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:roles) { [] }

  subject do
    build(:account, roles: roles)
  end

  it 'can be created' do
    expect { subject.save }.to_not raise_error
  end

  describe '#admin?' do
    it 'returns false unless user is an admin' do
      expect(subject.admin?).to eq(false)
    end

    context 'When the user has the admin role' do
      let(:roles) { [create(:role, name: 'admin')] }

      it 'returns if the user is an admin' do
        subject.save

        expect(subject.admin?).to eq(true)
      end
    end
  end

  describe '#has_role?' do
    it 'returns false unless user is an admin' do
      expect(subject.has_role?('admin')).to eq(false)
    end

    context 'When the user has the admin role' do
      let(:roles) { [create(:role, name: 'admin')] }

      it 'returns if the user is an admin' do
        subject.save

        expect(subject.has_role?('admin')).to eq(true)
      end
    end
  end
end
