require "#{Rails.root}/lib/group_name_generator"

# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  outing_id  :bigint           not null
#  name       :string
#  location   :string
#  max_size   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Group < ApplicationRecord
  belongs_to :outing

  has_many :group_members, dependent: :destroy
  has_many :accounts, through: :group_members

  UNBOUNDED_SIZE = -1
  DEFAULT_SIZE = 6 # Make this smarter later
  LOCATION_PENDING = 'TBD'

  scope :excluding_lobby, -> { where.not(max_size: UNBOUNDED_SIZE) }

  def self.generate_new
    new(
      name: GroupNameGenerator.get_name,
      location: LOCATION_PENDING,
      max_size: DEFAULT_SIZE
    )
  end

  def assign_to_group(account)
    group_members.create(
      account: account,
      status: GroupMember::UNKNOWN,
      status_updated_at: Time.now
    )
  end

  def full?
    !unbounded? || group_members.confirmed.count == max_size
  end

  def accepting_accounts?
    unbounded? || !full?
  end

  def unbounded?
    max_size == UNBOUNDED_SIZE
  end

  def participating_count
    group_members.not_declined.count
  end
end
