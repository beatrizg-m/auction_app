class Item < ApplicationRecord
  belongs_to :category
  belongs_to :batch, optional: true
  before_validation :generate_code
  validates :code, uniqueness: true

  def full_dimensions
    "#{width}cm X #{height}cm X #{depth}cm"
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
