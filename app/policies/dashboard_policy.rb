class DashboardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    is_admin?
  end

  private

  def is_admin?
    user.admin
  end
end
