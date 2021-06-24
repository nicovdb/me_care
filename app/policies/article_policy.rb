class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(published: true)
    end
  end

  def show?
    record_is_published?
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

  def record_is_published?
    record.published
  end
end
