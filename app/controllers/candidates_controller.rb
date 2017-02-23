class CandidatesController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @candidates = policy_scope(Candidate)
  end

  def show
    @candidate = Candidate.find(params[:id])
    authorize @candidate
  end
end
