class OutingPolicy < ApplicationPolicy
  authorize :user, allow_nil: true

  # Only users who happen to be in the gathering
  def show?
    admin? || record.gathering.member?(user)
  end

  def edit?
    show?
  end

  def update?
    edit?
  end

  def join?
    show?
  end

  # Same permissions as show, but not really used
  # as these are displayed at the gathering level
  def index?
    show?
  end
end
