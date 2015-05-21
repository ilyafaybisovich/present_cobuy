class ContributorMailer < ApplicationMailer
  default from: 'makers_academy_test@rbgeomatics.co.uk'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contributor_mailer.invited.subject
  #
  def invited(gift, contributor)
    @gift = gift
    @item = @gift.item
    email = contributor.email

    mail to: email, subject: "#{@gift.title} - You can make this happen!"
  end
end
