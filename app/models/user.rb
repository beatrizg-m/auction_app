class User < ApplicationRecord
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :assign_role
  validates :email, presence: true
  has_many :bids
  has_many :winning_batches, class_name: 'Batch', foreign_key: 'winner_id'
  validate :valid_cpf
  validates :role, presence: true

  enum role: { admin: 0, user: 1 }, _default: :user

  def full_description
    "#{name} - #{email}"
  end

  def valid_cpf
    unless CPF.valid?(cpf) && User.where(cpf: cpf).count == 0
      errors.add(:cpf, 'já esta em uso')
    end
  end

  def assign_role
    if email.include?('@leilaodogalpao.com.br')
      self.role = :admin
    elsif email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      self.role = :user
    else
      errors.add(:base, 'Email ou CPF não estão cadastrados nas tabelas correspondentes')
      throw(:abort)
    end
  end

  # def valid_email
  #   if email.present?
  #     if email.include?('@leilaodogalpao.com.br')
  #       self.role = :admin
  #     else
  #       self.role = :user
  #     end
  #   # elsif email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  #   #   self.role = 'user'
  #   else
  #     errors.add(:email, 'não é valido')
  #   end
  # end

  # def email_equal_to_do_domain
  #   if email.present? && company.present?
  #     domain = email.split('@')[-1]
  #     errors.add(:email, 'domínio do email não pertence a empresa') unless
  #                                                                   Company.where(id: company.id, domain:).first
  #   else
  #     errors.add(:email, 'domínio do email não pertence a empresa')
  #   end

  validates_uniqueness_of :cpf, :message => 'já esta em uso'

end
