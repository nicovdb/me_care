class SubscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where.not(status: "cancelled").where(user: user)
    end
  end

  def destroy?
    true
  end
end
