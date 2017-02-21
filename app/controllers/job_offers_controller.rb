class JobOffersController < ApplicationController
  before_action :set_job_offer, only: [:show, :edit, :update, :destroy]
  before_action :set_company, only: [:index, :new, :create]

  def index
    @job_offers = JobOffer.all
    @job_offers = policy_scope(JobOffer)
  end


  def show
  end

  def new
    @job_offer = JobOffer.new
    authorize @job_offer
  end

  def create
    @job_offer = JobOffer.new(job_offer_params)
    if @job_offer.save
      redirect_to job_offer_path(@job_offer)
    else
      render :new
    end
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
    authorize @job_offer
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def job_offer_params
    params.require(:job_offer).permit(:title, :document)
  end
end
