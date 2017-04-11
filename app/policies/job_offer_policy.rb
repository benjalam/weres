class JobOfferPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user == record.user
  end

  def show?
    user == record.user
  end


  def edit?
    user.company_admin || (user == record.user)
  end


  def update?
    user.company_admin || (user == record.user)
  end


  def new?
    user.company_admin
  end


  def create?
    user.company_admin
  end


  def destroy?
    user.company_admin || (user == record.user)
  end
end
