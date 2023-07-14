# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#full_dimensions' do
    it 'exibe todas as dimensões do item' do
      i = Item.new(width: 40, height: 30, depth: 40)

      result = i.full_dimensions

      expect(result).to eq('40cm X 30cm X 40cm')
    end
  end
end
