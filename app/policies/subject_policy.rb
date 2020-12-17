class SubjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_valid_subscription? || user.admin?
        scope.all
      else
        false
      end
    end
  end

  def show?
    has_valid_subscription? || is_admin?
  end

  def create?
    is_admin?
  end

  def update?
    is_admin?
  end

  private

  def has_valid_subscription?
    user.has_valid_subscription?
  end

  def is_admin?
    user.admin?
  end
end
