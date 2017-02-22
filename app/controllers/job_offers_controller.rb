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
    authorize @job_offer
    @job_offer.user = current_user
    if @job_offer.save
      redirect_to job_offer_path(@job_offer)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @job_offer.user = current_user
    if @job_offer.save
      redirect_to job_offer_path(@job_offer)
    else
      render :new
    end
  end

  def destroy
    @job_offer.delete
    redirect_to company_job_offers_path(@job_offer.user.company)
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

  def matching
    document1 = TfIdfSimilarity::Document.new("Benjamin Federico Julie")
    document2 = TfIdfSimilarity::Document.new("Benjamin Federico Leslie")
    document3 = TfIdfSimilarity::Document.new("Benjamin Federico Julie Jean")
    document4 = TfIdfSimilarity::Document.new("Benjamin Federico Julie Jean")

    @corpus = [document1, document2, document3, document4]
    model = TfIdfSimilarity::TfIdfModel.new(@corpus)
    matrix = model.similarity_matrix
    matrix[model.document_index(document1), model.document_index(document2)]
    matrix[model.document_index(document2), model.document_index(document3)]
    matrix[model.document_index(document1), model.document_index(document3)]
    tfidf_by_term = {}
    document1.terms.each do |term|
     tfidf_by_term[term] = model.tfidf(document1, term)
    end
    puts tfidf_by_term.sort_by{|_,tfidf| -tfidf}
  end

end
