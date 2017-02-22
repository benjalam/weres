class ContactedCandidatesController < ApplicationController
  def new
    @contacted_candidate = ContactedCandidate.new
  end

  def create
    @contacted_candidate = ContactedCandidate.new
    @candidate = Candidate.find(params[:id])
    @contacted_candidate.candidate = @candidate
    @job_offer = JobOffer.find(params[:job_offer_id])
    @contacted_candidate.job_offer = @job_offer
    @company = Company.find(params[:company_id])
    @contacted_candidate.company = @company
    @contacted_candidate.save
    redirect_to company_job_offer_candidates_path(@company, @job_offer)
  end
end
