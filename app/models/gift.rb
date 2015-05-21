class Gift < ActiveRecord::Base
  has_many :contributors
  accepts_nested_attributes_for :contributors
end
