# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, format: { with: /\A[^@]+@(?!.*leilaodogalpao)[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/ }
  has_many :bids
  has_many :winning_batches, class_name: 'Batch', foreign_key: 'winner_id'
  validate :valid_cpf

  def valid_cpf
    return if CPF.valid?(cpf) && Admin.where(cpf:).count.zero?

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
