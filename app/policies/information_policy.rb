class InformationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def update?
    is_current_user_or_admin?
  end

  private

  def is_current_user_or_admin?
    record.user == user || user.admin
  end
end
