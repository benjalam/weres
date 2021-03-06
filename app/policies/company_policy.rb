class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.company == record
  end

  def index?
    user.company == record
  end
end
