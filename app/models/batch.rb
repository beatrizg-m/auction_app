class Batch < ApplicationRecord
  has_many :items, dependent: :nullify
  validates :code, :start_date, :final_date, :minimum_value, :minimum_difference, :presence => true
  validates :code, :uniqueness => true
  validates_format_of :code, with: /\A(?=.*[a-zA-Z].*[a-zA-Z].*[a-zA-Z])[a-zA-Z0-9]{9}\z/

  accepts_nested_attributes_for :items, :allow_destroy => :false
end
