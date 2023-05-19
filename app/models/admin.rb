class Admin < ApplicationRecord

  validates :email, presence: true, format: { with: /\b[\w\.-]+@leilaodogalpao\.com\.br\b/}
  validate :valid_cpf

  def valid_cpf
    unless CPF.valid?(cpf)
      errors.add(:cpf, 'já esta em uso')
    end
  end

  validates_uniqueness_of :cpf, :message => 'já esta em uso'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
