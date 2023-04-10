# == Schema Information
#
# Table name: account_roles
#
#  id         :bigint           not null, primary key
#  account_id :bigint           not null
#  role_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe AccountRole, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
