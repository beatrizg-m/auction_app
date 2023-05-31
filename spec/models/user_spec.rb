require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#full_description' do
    it 'exibe nome e email do usuário' do
      u = User.new(name: 'Beatriz', email: 'beatriz@leilaodogalpao.com.br')

      result = u.full_description

      expect(result).to eq('Beatriz - beatriz@leilaodogalpao.com.br')
    end
  end
end
