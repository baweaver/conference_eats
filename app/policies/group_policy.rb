class GroupPolicy < ApplicationPolicy
  authorize :user, allow_nil: true

  # Only users who happen to be in the group
  def show?
    admin? || record.member?(user)
  end

  # Only the admin can get a full view of every group, just so
  # we avoid people seeing who all might be going where.
  #
  # The actual listing will happen on the outing.
  def index?
    admin?
  end
end
