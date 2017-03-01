class UserMailerPreview < ActionMailer::Preview
  def inmail
    candidate = Candidate.first
    job_offer = candidate.job_offer.title
    UserMailer.inmail(candidate, job_offer)
  end
end
