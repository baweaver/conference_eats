# == Schema Information
#
# Table name: gathering_members
#
#  id           :bigint           not null, primary key
#  gathering_id :bigint           not null
#  blocked      :boolean
#  block_reason :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :bigint
#
require 'rails_helper'

RSpec.describe GatheringMember, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
