class CandidatesController < ApplicationController
  def index
    @candidates = policy_scope(Candidate)
  end

  def show
    @candidate = Candidate.find(params[:id])
    authorize @candidate
  end
end
