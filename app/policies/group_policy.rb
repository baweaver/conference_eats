class GroupPolicy < ApplicationPolicy
  authorize :user, allow_nil: true

  # Only users who happen to be in the group
  def show?
    admin? || record.member?(user)
  end

  # Only logged in users
  def index?
    user.present?
  end
end
