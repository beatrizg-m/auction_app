class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :batch
  validates :value, presence: true
end
