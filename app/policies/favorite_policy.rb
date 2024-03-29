class FavoritePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def destroy?
    true
  end

  private

  def is_admin?
    user.admin?
  end
end
