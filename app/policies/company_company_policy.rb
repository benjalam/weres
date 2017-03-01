class CompanyCompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.company_admin && (user.company == record.company)
  end
  def destroy?
    user.company_admin && (user.company == record.company)
  end
end
