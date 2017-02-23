class JobOffersController < ApplicationController
require 'matrix'
  before_action :set_job_offer, only: [:show, :edit, :update, :destroy]
  before_action :set_company, only: [:index, :new, :create]

  def index
    @job_offers = JobOffer.all
    @job_offers = policy_scope(JobOffer)
    # script_hacker
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
    @job_offer.tfidf = conversion(@job_offer)
    if @job_offer.save
      matching(@job_offer)
      redirect_to job_offer_path(@job_offer)
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
    @job_offer.delete
    redirect_to company_path(@job_offer.user.company)
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

  def print_time(start, step)
    puts " TIME FOR #{step} ==> #{Time.now - start}"
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

  def matching(offer)
    start = Time.now
    # 1) Find last uploaded offer (TFIDF from database)
    offer_tfidf = offer.to_tfidf

    #2) Select all offers with CV associated => start_corpus
    corpus = []
    job_offers = JobOffer.all
    # job_offers =  JobOffer.includes(:candidates).joins(:document_files).all
    job_offers.each do |job_offer|
      unless job_offer.document.nil?
       corpus << {offer: job_offer, tfidf: job_offer.to_tfidf}
      end
    end
    @corpus = corpus.map {|c| c[:tfidf]}


    #3) Add our offer to start_corpus => corpus completed
    @corpus << offer_tfidf
    print_time(start, 'SET CORPUS')

    # 4) Build model + matrix
    model = TfIdfSimilarity::TfIdfModel.new(@corpus)
    matrix = model.similarity_matrix
    print_time(start, 'SET MODEL')
    #5 Iterate to get scores
    @scores = []
    corpus.each do |job_offer|
      @scores << { job_offer: job_offer[:offer],
                   score: matrix[model.document_index(job_offer[:tfidf]), model.document_index(offer_tfidf)]
                 }
    end
    print_time(start, 'SCORE')
    @scores = @scores.sort_by {|hash| hash[:score]}
    print_time(start, 'SORT SCORE')
  end


end
