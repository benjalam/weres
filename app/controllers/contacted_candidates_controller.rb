class ContactedCandidatesController < ApplicationController
  def new
    @contacted_candidate = ContactedCandidate.new
    authorize @contacted_candidate
  end

  def create
    @contacted_candidate = ContactedCandidate.new
    @candidate = Candidate.find(params[:candidate_id])
    @contacted_candidate.candidate = @candidate

    @job_offer = JobOffer.find(params[:job_offer_id])
    @contacted_candidate.job_offer = @job_offer

    @company = Company.find(params[:company_id])
    @contacted_candidate.company = @company
    authorize @contacted_candidate
    @contacted_candidate.save

    UserMailer.inmail(@candidate).deliver_now

    redirect_to company_candidates_path(@company)
  end
end
