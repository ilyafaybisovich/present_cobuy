class Gift < ActiveRecord::Base
  has_many :contributors
  accepts_nested_attributes_for :contributors, reject_if: :all_blank, allow_destroy: true
  after_save :notify_contributors

  def notify_contributors
    self.contributors.each do |contributor|
      ContributorMailer.invited(self, contributor).deliver
    end
  end

end
