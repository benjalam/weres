class CandidatesController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @candidates = policy_scope(Candidate)
  end

  def show
    @company = Company.find(params[:company_id])
    @job_offer = JobOffer.find(params[:job_offer_id])
    @candidate = Candidate.find(params[:id])
    authorize @candidate
  end

  def new
    @candidate = Candidate.new
    authorize @candidate
  end

  def create
    @candidate = Candidate.new(candidate_params)
    @candidate.user = current_user
    authorize @candidate
    if @candidate.save
      redirect_to :root
    else
      render :new
    end
  end

  def upvote
    @candidate = Candidate.find(params[:id])
    authorize @candidate
    job_offer = JobOffer.find(params[:job_offer_id])
    if job_offer.voted_for? @candidate
       job_offer.unvote_for @candidate
    else
      job_offer.up_votes @candidate
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :position, :document, :email)
  end

end
