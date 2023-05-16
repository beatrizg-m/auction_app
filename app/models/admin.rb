class Admin < ApplicationRecord

  validate :valid_cpf

  def valid_cpf
    unless CPF.valid?(cpf)
      errors.add(:cpf, 'já esta em uso')
    end
  end

  validates_uniqueness_of :cpf

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
