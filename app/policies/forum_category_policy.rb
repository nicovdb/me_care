class ForumCategoryPolicy < ApplicationPolicy
    class Scope < Scope
    def resolve
      if is_admin?
        scope.all
      else
        false
      end
    end
  end

  def create?
    is_admin?
  end

  def update?
    is_admin?
  end

  private

  def is_admin?
    user.admin?
  end
end
