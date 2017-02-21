class CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :show, :update]
  # skip_after_action :verify_policy_scoped, only: :show

  def show
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

