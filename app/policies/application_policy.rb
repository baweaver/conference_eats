# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  default_rule :manage?

  # Default permissions: If you're not an admin it's false.
  #
  # Some cascading permissions as I probably don't care to repeat
  # the tuples like (edit, update) and (new, create) as they're almost
  # certainly the same.
  #
  # With show / index that may be a bit more thought through, but probably safe
  # to cascade them as a default.
  def show? = index?
  def index? = manage?

  def edit? = update?
  def update? = manage?

  def new? = create?
  def create? = manage?

  def destroy? = manage?

  def manage?
    user.admin?
  end

  protected def admin?
    user.admin?
  end
end
