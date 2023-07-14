class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :assign_role
  validates :email, presence: true
  validate :valid_cpf
  validates :role, presence: true
  validates_uniqueness_of :cpf, message: 'já esta em uso'

  has_many :bids
  has_many :winning_batches, class_name: 'Batch', foreign_key: 'winner_id'

  enum role: { admin: 0, user: 1 }

  def full_description
    "#{name} - #{email}"
  end

  def valid_cpf
    return if CPF.valid?(cpf) && User.where(cpf:).count.zero?

    errors.add(:cpf, 'já esta em uso')
  end

  def assign_role
    if email.include?('@leilaodogalpao.com.br')
      self.role = 0
    elsif email.match(/\A[\w+\-.]+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i)
      self.role = 1
    else
      errors.add(:base, 'Email ou CPF não estão cadastrados nas tabelas correspondentes')
      throw(:abort)
    end
  end
end
