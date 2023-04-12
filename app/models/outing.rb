# == Schema Information
#
# Table name: outings
#
#  id           :bigint           not null, primary key
#  name         :string
#  start_time   :date
#  end_time     :date
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  gathering_id :string
#
class Outing < ApplicationRecord
  belongs_to :gathering
  has_many :groups

  DEFAULT_GATHERING_PLACE = 'Gathering Venue'
  NO_LIMIT = -1

  def assign_to_group(account)
    # TODO: Handle case where rejoin, but has a group, and not declined
    #

    potential_groups = groups.not_full.not_declined_by(account)

    # If there are no groups make one
    selected_group = if potential_groups.any?
      potential_groups.first
    else
      Group.new.tap { groups << _1 }
    end

    selected_group.assign_to_group(account)
    selected_group
  end

  # Update this to deal with declines later
  def full_groups
    groups
      .excluding_lobby
      .joins(:group_members)
      .group('groups.id')
      .having('count(group_id) >= max_size')
  end

  # Update this to deal with declines later
  def open_groups
    groups
      .excluding_lobby
      .joins(:group_members)
      .group('groups.id')
      .having('count(group_id) < max_size')
  end

  def default_group
    groups.find_or_create_by(
      name: DEFAULT_GATHERING_PLACE,
      location: gathering.location,
      max_size: NO_LIMIT
    )
  end

  def join_lobby(account)
    default_group.assign_to_group(account)
  end

  def populate_lobby
    gathering.accounts.each { |account| join_lobby(account) }
  end
end
