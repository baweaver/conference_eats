# == Schema Information
#
# Table name: gathering_accounts
#
#  id           :integer          not null, primary key
#  gathering_id :integer          not null
#  account_id      :integer          not null
#  blocked      :boolean
#  block_reason :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe GatheringAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
