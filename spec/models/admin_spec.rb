# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#full_description' do
    it 'exibe nome e email do usuário' do
      a = Admin.new(name: 'Beatriz', email: 'beatriz@leilaodogalpao.com.br')

      result = a.full_description

      expect(result).to eq('Beatriz - beatriz@leilaodogalpao.com.br')
    end
  end
end
