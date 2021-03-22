class CouponCodePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.superadmin
        scope.all
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  def create?
    is_superadmin?
  end

  def use?
    true
  end

  private

  def is_superadmin?
    user.superadmin
  end
end
