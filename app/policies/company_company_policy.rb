class CompanyCompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.company_admin
  end
  def destroy?
    user.company_admin
  end
end
