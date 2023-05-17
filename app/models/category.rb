class Category < ApplicationRecord
  validates  :name, :description, presence:true
end
