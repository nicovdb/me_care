class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    is_admin?
  end

  def show?
    true
  end

  private

  def is_admin?
    user.admin
  end
end
