class CandidatesController < ApplicationController
  def index
    @candidates = Candidates.all
  end

  def show
    @company = Company.find(params[:company_id])
    @candidate = Candidate.find(params[:id])
  end
end
