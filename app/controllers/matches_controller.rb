class MatchesController < ApplicationController
  def index


  end

  def show
    @match = Match.find(params[:id])
    @job_offer = JobOffer.find(params[:job_offer_id])
    @candidate = Candidate.find(@match.candidate_id)
  end

  def edit

  end

  def update

  end
end
