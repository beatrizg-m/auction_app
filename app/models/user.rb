class User < ApplicationRecord
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  has_many :bids
  has_many :winning_batches, class_name: 'Batch', foreign_key: 'winner_id'
  validate :valid_cpf
  before_validation :valid_email

  enum role: [ :admin, :user ]

  def full_description
    "#{current_user.name} - #{current_user.email}"
  end

  def valid_cpf
    unless CPF.valid?(cpf) && User.where(cpf: cpf).count == 0
      errors.add(:cpf, 'já esta em uso')
    end
  end

  def valid_email
    if email.match(/\b[\w\.-]+@leilaodogalpao\.com\.br\b/)
      self.role = :admin
    elsif email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      self.role = :user
    else
      errors.add(:email, 'não é valido')
    end
  end

  validates_uniqueness_of :cpf, :message => 'já esta em uso'

end
