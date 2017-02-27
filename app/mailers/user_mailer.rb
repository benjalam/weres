class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.inmail.subject
  #
  def inmail(candidate)
    @candidate = candidate
    @company = @candidate.user.company.name
    mail(to: @candidate.email, subject: 'WeRes has a new job opportunity for you !')
  end
end
