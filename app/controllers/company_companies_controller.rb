class CompanyCompaniesController < ApplicationController

  def new
    @company_company = CompanyCompany.new
  end

  def create
    @company_company = CompanyCompany.new
    @company = Company.find(params[:company_id])
    @company_company.company = @company
    @company_company.black_listed_company = Company.find(params[:company_company][:company])
    @append = @company_company.black_listed_company

    authorize @company_company
    if @company_company.save
      @companies_not_black_listed = @company.not_black_listed_companies

      respond_to do |format|
        format.html { redirect_to company_path(@company) }
        format.js  # <-- will render `app/views/reviews/create.js.erb
      end
    else
      respond_to do |format|
        format.html { render "companies/show" }
        format.js
      end
    end
  end

  def destroy
    @company_company = CompanyCompany.find(params[:id])
    authorize @company_company
    @company_company.destroy
    @company = @company_company.company
    @companies_not_black_listed = @company.not_black_listed_companies
  end
end
