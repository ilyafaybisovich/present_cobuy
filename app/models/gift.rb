class Gift < ActiveRecord::Base
  after_save :notify_contributors

  def notify_contributors
    self.contributors.each do |contributor|
      ContributorMailer.invited(self, contributor).deliver
    end
  end
end
