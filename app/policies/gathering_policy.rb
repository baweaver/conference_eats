class GatheringPolicy < ApplicationPolicy
  authorize :user, allow_nil: true

  # Only users who happen to be in the gathering
  def show?
    admin? || record.member?(user)
  end

  # You should be logged in to see this
  def index?
    user.present? # and later user not blocked?
  end
end
