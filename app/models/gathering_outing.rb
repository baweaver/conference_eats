# == Schema Information
#
# Table name: gathering_outings
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
class GatheringOuting < ApplicationRecord
  belongs_to :gathering
  has_many :gathering_outing_groups

  DEFAULT_GATHERING_PLACE = 'Gathering Venue'
  NO_LIMIT = -1

  def default_group
    gathering_outing_groups.find_or_create_by(
      name: DEFAULT_GATHERING_PLACE,
      max_size: NO_LIMIT
    )
  end

  def join_lobby(account)
    default_group.accounts << account
  end

  def populate_lobby
    gathering.accounts.each { |account| join_lobby(account) }
  end
end