class Gift < ActiveRecord::Base
  has_many :contributors
  accepts_nested_attributes_for :contributors, reject_if: :all_blank, allow_destroy: true
end
