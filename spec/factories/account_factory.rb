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
FactoryBot.define do
  factory :account do
    status { "verified" }
    email { Faker::Internet.email }
    password_hash { BCrypt::Password.create('password').to_s }
    profile { nil }
  end
end
