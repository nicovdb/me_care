class SubjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      #if user.has_valid_subscription? || user.admin?
        scope.all
      # else
      #   raise Pundit::NotAuthorizedError
      # end
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    is_admin_or_owner?
  end

  def destroy?
    is_admin_or_owner?
  end

  private

  def has_valid_subscription?
    user.has_valid_subscription?
  end

  def is_admin?
    user.admin?
  end

  def is_admin_or_owner?
    record.user == user || user.admin
  end
end
