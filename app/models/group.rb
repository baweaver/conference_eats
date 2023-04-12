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

  # Lobbies are where we distribute folks from, -1 allows for overloading
  # that idea
  UNBOUNDED_SIZE = -1

  # These ones I may make configurable at the group level later.
  DEFAULT_SIZE = 6 # Make this smarter later
  LOCATION_PENDING = 'TBD'

  # Defaults
  attribute :name, default: -> { GroupNameGenerator.get_name }
  attribute :max_size, default: -> { DEFAULT_SIZE }
  attribute :location, default: -> { LOCATION_PENDING }

  scope :excluding_lobby, -> { where.not(max_size: UNBOUNDED_SIZE) }

  # Does this account have any groups they're active in and haven't declined?
  #
  # Do note that this one is far more useful when merged to an outing.
  def self.has_live_membership?(account)
    excluding_lobby
      .joins(:group_members)
      .merge(GroupMember.account_not_declined(account))
      .exists?
  end

  # Find groups where the account has not explicitly declined, nor
  # is included in
  def self.not_declined_by(account)
    # Include non-existing accounts on left-side
    left_joins(:group_members)
      .merge(GroupMember.account_not_in_or_declined(account))
      .distinct
  end

  # Groups which are not full
  def self.not_full
    excluding_lobby
      .left_joins(:group_members) # Include zero counts
      .group('groups.id')
      .having('count(group_members) < max_size')
  end

  # Groups which are full
  def self.full
    excluding_lobby
      .left_joins(:group_members) # Include zero counts
      .group('groups.id')
      .having('count(group_members) >= max_size')
  end

  def assign_to_group(account)
    # Should not happen with above check, need to think on this
    return false if group_members.exists?(account:, status: 'declined')

    accounts << account
  end

  def member?(account)
    group_members.where(account_id: account.id).where.not(status: 'declined').exists?
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

  # Will remove this later, but useful if I get lost in permissions
  def test_report
    {
      group: name,
      member_stats: group_members.to_h { [_1.account_id, _1.status] }
    }.then { puts JSON.pretty_generate(_1) }
  end
end
