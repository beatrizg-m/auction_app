class Item < ApplicationRecord
  belongs_to :category
  before_save :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10)
  end
end
