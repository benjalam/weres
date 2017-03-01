class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.inmail.subject
  #
  def inmail(candidate, job_offer)
    @candidate = candidate
    @job_offer = job_offer.title
    @company = @candidate.user.company.name
    mail(to: @candidate.email, subject: 'We.Res has a new job opportunity for you !')
  end
end
