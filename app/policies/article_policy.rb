class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.includes([:cover_attachment])
    end
  end

  def show?
    true
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

  def is_admin?
    user.admin
  end
end
