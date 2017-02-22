class CompanycompaniesController < ApplicationController
  def index
    @company_companies = CompanyCompany.all
  end

  def new
    @company_company = CompanyCompany.new
  end

  def create
    @company_company = CompanyCompany.new(company_company_params)
    @cocktail = Company.find(params[:company_id])
    @company_company.company = @company
    if @company_company.save
      redirect_to company_path(@company)
    else
      render "companies/show"
    end
  end

  def destroy

  end

  private

  def dose_params
    params.require(:company_company).permit(:name)
  end
end
