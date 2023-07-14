# frozen_string_literal: true

class Admin < ApplicationRecord
  validates :email, presence: true, format: { with: /\b[\w.-]+@leilaodogalpao\.com\.br\b/ }
  validate :valid_cpf

  def valid_cpf
    return if CPF.valid?(cpf)

    errors.add(:cpf, 'já esta em uso')
  end

  validates_uniqueness_of :cpf, message: 'já esta em uso'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_description
    "#{name} - #{email}"
  end
end
