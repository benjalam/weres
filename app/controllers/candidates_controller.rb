class CandidatesController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @candidates = policy_scope(Candidate)
    @company.job_offers.each do |job_offer|


  end

  def show
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
    if current_user.voted_for? @candidate
      current_user.unvote_for @candidate
    else
      current_user.up_votes @candidate
    end
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :position)
  end

end
