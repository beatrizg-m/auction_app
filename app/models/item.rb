class Item < ApplicationRecord
  belongs_to :category
  belongs_to :batch, optional: true
  before_save :generate_code
  validates :code, uniqueness: true
  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10)
  end
end
