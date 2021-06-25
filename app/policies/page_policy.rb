class PagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def algorythm?
    true
  end

  private

  def has_valid_subscription?
    user.has_valid_subscription?
  end

  def is_admin?
    user.admin?
  end
end
