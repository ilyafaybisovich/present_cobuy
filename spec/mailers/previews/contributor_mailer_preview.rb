# Preview all emails at http://localhost:3000/rails/mailers/contributor_mailer
class ContributorMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contributor_mailer/invited
  def invited
    ContributorMailer.invited
  end

end
