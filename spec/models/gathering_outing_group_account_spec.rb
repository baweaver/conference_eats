# == Schema Information
#
# Table name: gathering_outing_group_users
#
#  id                        :integer          not null, primary key
#  user_id                   :integer          not null
#  gathering_outing_group_id :integer          not null
#  status                    :string
#  status_updated_at         :date
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
require 'rails_helper'

RSpec.describe GatheringOutingGroupAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
