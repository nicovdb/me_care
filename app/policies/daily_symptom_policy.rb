class DailySymptomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    has_valid_subscription? || is_admin?
  end

  def update?
    has_valid_subscription? || is_admin?
  end

  def graph?
    has_valid_subscription? || is_admin?
  end

  private

  def has_valid_subscription?
    user.has_valid_subscription?
  end

  def is_admin?
    user.admin?
  end
end
