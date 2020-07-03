class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where.not(name: 'Trial')
    end
  end


end
