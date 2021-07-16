class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def destroy?
    is_admin_or_owner?
  end

  private

  def has_valid_subscription?
    user.has_valid_subscription?
  end

  def is_admin_or_owner?
    user.admin? || record.user == user
  end
end
