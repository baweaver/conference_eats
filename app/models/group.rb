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

  has_many :group_members
  has_many :accounts, through: :group_members

  scope :with_members, -> { joins(:group_members) }

  scope :confirmed_accounts, -> { with_members.merge(GroupMembers.confirmed) }
  scope :declined_accounts, -> { with_members.merge(GroupMembers.declined) }
  scope :unknown_accounts, -> { with_members.merge(GroupMembers.unknown) }

  UNBOUNDED_SIZE = -1

  def full?
    !unbounded? || group_members.confirmed.count == max_size
  end

  def accepting_accounts?
    unbounded? || !full?
  end

  def unbounded?
    max_size == UNBOUNDED_SIZE
  end
end
