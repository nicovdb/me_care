class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    is_current_user_or_admin?
  end

  private

  def is_current_user_or_admin?
    record == user || user.admin
  end
end