class InfoendoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      #if user.admin? || user.has_valid_subscription?
        scope.where(published: true)
      # else
      #   raise Pundit::NotAuthorizedError
      # end
    end
  end

  def show?
    (record_is_published?) || is_admin?
  end

  def create?
    is_admin?
  end

  def update?
    is_admin?
  end

  def destroy?
    is_admin?
  end

  private

  def has_valid_subscription?
    user.has_valid_subscription?
  end

  def is_admin?
    user.admin?
  end

  def record_is_published?
    record.published
  end
end
