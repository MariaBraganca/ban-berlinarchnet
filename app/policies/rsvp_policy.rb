class RsvpPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def new
    return true
  end

  def destroy?
    true
  end
end
