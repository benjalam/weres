class ContactedCandidatePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    user.company == company
  end

  def create?
    user.company == company
  end
end
