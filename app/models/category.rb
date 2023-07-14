# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, :description, presence: true
end
