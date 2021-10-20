class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    is_current_user_or_admin?
  end

  def update?
    is_current_user_or_admin?
  end

  def forum_consent?
    is_current_user_or_admin?
  end

  def become_admin?
    is_admin?
  end

  def undo_admin?
    is_admin?
  end

  def desactivate?
    is_admin?
  end

  def reactivate?
    is_admin?
  end

  def anonymize?
    is_current_user_or_admin?
  end

  private

  def is_current_user_or_admin?
    record == user || user.admin
  end

  def is_admin?
    user.admin
  end
end
