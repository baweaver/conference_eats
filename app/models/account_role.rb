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
class AccountRole < ApplicationRecord
  belongs_to :account
  belongs_to :role
end
