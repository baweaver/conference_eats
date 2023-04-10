# == Schema Information
#
# Table name: accounts
#
#  id            :bigint           not null, primary key
#  status        :integer          default("unverified"), not null
#  email         :citext           not null
#  password_hash :string
#  profile_id    :bigint
#
class Account < ApplicationRecord
  include Rodauth::Rails.model
  enum :status, unverified: 1, verified: 2, closed: 3

  has_many :account_roles
  has_many :roles, through: :account_roles

  has_one :profile
  accepts_nested_attributes_for :profile

  def admin?
    has_role?('admin')
  end

  def has_role?(role_name)
    roles.exists?(name: role_name)
  end
end
