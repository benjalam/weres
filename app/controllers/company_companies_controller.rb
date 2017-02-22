class CompanyCompaniesController < ApplicationController

  def new
    @company_company = CompanyCompany.new
  end

  def create
    @company_company = CompanyCompany.new
    @company = Company.find(params[:company_id])
    @company_company.company = @company
    @company_company.black_listed_company = Company.find(params[:company_company][:company])
    authorize @company_company
    if @company_company.save
      redirect_to company_path(@company)
    else
      render "companies/show"
    end
  end

  def destroy
    @company_company = CompanyCompany.find(params[:id])
    authorize @company_company
    @company_company.delete
    redirect_to company_path(@company_company.company)
  end
end
