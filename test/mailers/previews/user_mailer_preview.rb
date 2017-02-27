class UserMailerPreview < ActionMailer::Preview
  def inmail
    candidate = Candidate.first
    UserMailer.inmail(candidate)
  end
end
