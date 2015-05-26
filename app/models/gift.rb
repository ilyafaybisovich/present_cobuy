class Gift < ActiveRecord::Base
  has_many :contributors
  accepts_nested_attributes_for :contributors,
                                reject_if: :all_blank,
                                allow_destroy: true
  after_create :notify_contributors

  def notify_contributors
    self.contributors.each do |contributor|
      ContributorMailer.invited(self, contributor).deliver_later
    end
  end

  def paid_contributors
    self.contributors.inject(0) do |sum, contributor|
      contributor.token.nil? ? sum : sum += 1
    end
  end

  def percentage_complete
    ((paid_contributors.to_f / self.contributors.count) * 100).to_i
  end

  def all_contributed?
    contributed = self.contributors.inject(0) do |sum, contributor|
      contributor.token.nil? ? sum : sum += 1
    end
    self.contributors.count == contributed
  end
end
