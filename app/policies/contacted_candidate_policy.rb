class ContactedCandidatePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    user.company == record.company
  end

  def create?
    user.company == record.company
  end
end
