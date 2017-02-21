class JobOffersController < ApplicationController
  before_action :set_job_offer, only: [:show, :edit, :update, :destroy]
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @job_offers = JobOffer.all
  end


  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

private

  def set_job_offer
    @job_offer = JobOffer.find(params[:id])
  end

  def set_company
    @job_offer = JobOffer.find(params[:company_id])
  end
end
