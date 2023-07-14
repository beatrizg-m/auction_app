# frozen_string_literal: true

class Batch < ApplicationRecord
  has_many :items, class_name: 'Item', dependent: :nullify
  has_many :bids
  belongs_to :winner, class_name: 'User', optional: true
  validates :code, :start_date, :final_date, :minimum_value, :minimum_difference, presence: true
  validates :code, uniqueness: true
  validates_format_of :code, with: /\A(?=.*[a-zA-Z].*[a-zA-Z].*[a-zA-Z])[a-zA-Z0-9]{9}\z/

  accepts_nested_attributes_for :items, allow_destroy: false

  def in_progress?
    approved && (start_date.past? || start_date.today?) && (final_date.future? || final_date.today?)
  end

  def finished?
    approved && final_date.past?
  end
end
