class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :show, :update]
  # skip_after_action :verify_policy_scoped, only: :show



  def show
    @companies_not_black_listed = @company.not_black_listed_companies
    @job_offer = JobOffer.new
    @company_company = CompanyCompany.new
    @black_listed = CompanyCompany.new
  end

  def edit
  end

  def update
    @company.update(company_params)
    redirect_to company_path(@company)
  end

  private

  def set_company
    @company = Company.find(params[:id])
    authorize @company
  end
end

