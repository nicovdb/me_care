class CouponPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    is_admin?
  end

  def use?
    true
  end

  private

  def is_admin?
    user.admin?
  end
end
