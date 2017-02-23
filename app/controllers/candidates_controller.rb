class CandidatesController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @candidates = policy_scope(Candidate)

  end

  def show
    @candidate = Candidate.find(params[:id])
    authorize @candidate
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

end
