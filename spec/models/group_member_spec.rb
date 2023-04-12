# == Schema Information
#
# Table name: group_members
#
#  id                :bigint           not null, primary key
#  group_id          :bigint           not null
#  status            :string
#  status_updated_at :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :bigint
#
require 'rails_helper'

RSpec.describe GroupMember, type: :model do
  # Explicitly scopes are meant to be read only. Create records _once_
  # for these.
  describe 'Scopes' do
    let_it_be(:gathering) { create(:gathering, name: 'GroupMember') }
    let_it_be(:outing) { create(:outing, name: 'GroupMember Outing', gathering:) }
    let_it_be(:group) { create(:group, name: 'GroupMember Group', outing:) }

    let_it_be(:confirmed_member) do
      create(:group_member, group:, account: create(:account), status: 'confirmed')
    end

    let_it_be(:declined_member) do
      create(:group_member, group:, account: create(:account), status: 'declined')
    end

    let_it_be(:second_declined_member) do
      create(:group_member, group:, account: create(:account), status: 'declined')
    end

    let_it_be(:pending_member) do
      create(:group_member, group:, account: create(:account), status: 'pending')
    end

    describe '.confirmed' do
      it 'returns confirmed members' do
        confirmed_members = GroupMember.confirmed

        expect(confirmed_members).to include(confirmed_member)
        expect(confirmed_members).to_not include(declined_member, pending_member)
      end
    end

    describe '.declined' do
      it 'returns declined members' do
        declined_members = GroupMember.declined

        expect(declined_members).to include(declined_member)
        expect(declined_members).to_not include(confirmed_member, pending_member)
      end
    end

    describe '.pending' do
      it 'returns pending members' do
        pending_members = GroupMember.pending

        expect(pending_members).to include(pending_member)
        expect(pending_members).to_not include(confirmed_member, declined_member)
      end
    end

    describe '.not_declined' do
      it 'returns not_declined members' do
        not_declined_members = GroupMember.not_declined

        expect(not_declined_members).to include(confirmed_member, pending_member)
        expect(not_declined_members).to_not include(declined_member)
      end
    end

    describe '.account_confirmed' do
      it 'returns members that have confirmed a specific account' do
        confirmed_account_members = GroupMember.account_confirmed(confirmed_member.account)

        expect(confirmed_account_members).to include(confirmed_member)
        expect(confirmed_account_members).to_not include(declined_member, pending_member)
      end
    end

    describe '.account_declined' do
      it 'returns members that have declined a specific account' do
        declined_account_members = GroupMember.account_declined(declined_member.account)

        expect(declined_account_members).to include(declined_member)
        expect(declined_account_members).to_not include(confirmed_member, pending_member)
      end
    end

    describe '.account_pending' do
      it 'returns members that have pending a specific account' do
        pending_account_members = GroupMember.account_pending(pending_member.account)

        expect(pending_account_members).to include(pending_member)
        expect(pending_account_members).to_not include(confirmed_member, declined_member)
      end
    end

    describe '.account_not_declined' do
      it 'returns members that have not_declined a specific account' do
        not_declined_account_members = GroupMember.account_not_declined(confirmed_member.account)

        expect(not_declined_account_members).to include(confirmed_member)
        expect(not_declined_account_members).to_not include(declined_member, pending_member)
      end
    end

    describe '.account_not_in' do
      it 'returns members that are not in a specific account' do
        not_in_account_members = GroupMember.account_not_in(confirmed_member.account)

        expect(not_in_account_members).to_not include(confirmed_member)
        expect(not_in_account_members).to include(declined_member, pending_member)
      end
    end

    describe '.account_not_in_or_declined' do
      it 'returns members that are not in a specific account nor are declined' do
        not_in_or_declined_account_members = GroupMember
          .account_not_in_or_declined(declined_member.account)

        expect(not_in_or_declined_account_members).to include(
          confirmed_member,
          pending_member,
          second_declined_member
        )

        expect(not_in_or_declined_account_members).to_not include(declined_member)
      end
    end
  end
end
