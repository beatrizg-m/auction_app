class Batch < ApplicationRecord
  has_many :items, dependent: :nullify
  validates :code, :start_date, :final_date, :minimum_value, :minimum_difference, :presence => true

  accepts_nested_attributes_for :items, :allow_destroy => :false
end
