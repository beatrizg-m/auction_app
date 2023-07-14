# frozen_string_literal: true

require 'rails_helper'

describe 'User is authenticated' do
  it 'successfully' do
    User.create!(email: 'vanessa@gmail.com', password: '123456', password_confirmation: '123456', cpf: '87777471007')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'Email', with: 'vanessa@gmail.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'vanessa@gmail.com'
      expect(page).not_to have_link 'Entrar como usuario'
    end
  end
end
