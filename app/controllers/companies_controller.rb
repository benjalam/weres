class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :show, :update]
  # skip_after_action :verify_policy_scoped, only: :show



  def show
    companies = Company.all
    black_listed_companies = @company.black_listed_companies
    current_company = []
    current_company << @company
    @job_offer = JobOffer.new
    if (companies - black_listed_companies) == []
      @companies_not_black_listed = []
    else
      @companies_not_black_listed = companies - black_listed_companies - current_company
    end
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

