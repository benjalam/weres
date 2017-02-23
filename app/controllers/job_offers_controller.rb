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
    script_hacker
    @job_offer = JobOffer.new
    authorize @job_offer
  end

  def create
    @job_offer = JobOffer.new(job_offer_params)
    authorize @job_offer
    @job_offer.user = current_user
    @job_offer.tfidf = conversion(@job_offer)
    if @job_offer.save
      Matching.new.matching(@job_offer)
      redirect_to  "/companies/#{@company.id}/candidates#job_offer_#{@job_offer.id}"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @job_offer.user = current_user
    @job_offer.update(job_offer_params)
    redirect_to company_path(current_user.company, anchor: "job_offers")
  end

  def destroy
    @company = @job_offer.user.company
    @job_offer.delete
    redirect_to "/companies/#{@company.id}#job_offers"
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

  def conversion(offer)
    yomu = Yomu.new offer.document.fullpath
    offer = TfIdfSimilarity::Document.new(yomu.text)
    new_doc = { text: offer.text,
                term_counts: offer.term_counts,
                size: offer.size
              }
  end

  def script_hacker
    JobOffer.all.each do |job_offer|
      unless job_offer.document.nil?
        job_offer.tfidf = conversion(job_offer)
        job_offer.save
      end
    end

  end
end
