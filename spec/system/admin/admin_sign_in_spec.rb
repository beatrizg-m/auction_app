# frozen_string_literal: true

require 'rails_helper'

describe 'Admin authenticates' do
  it 'successfully' do
    Admin.create!(email: 'maria@leilaodogalpao.com.br', password: 'password',
                  password_confirmation: 'password', cpf: '11965580432')

    visit root_path
    click_on 'Entrar como Administrador'
    within('form') do
      fill_in 'E-mail', with: 'maria@leilaodogalpao.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'maria@leilaodogalpao.com.br'
      expect(page).not_to have_link 'Entrar como administrador'
    end
  end

  it "but you don't have the correct domain" do
    Admin.create!(email: 'maria@leilaodogalpao.com.br', password: 'password',
                  password_confirmation: 'password', cpf: '11965580432')

    visit root_path
    click_on 'Entrar como Administrador'
    within('form') do
      fill_in 'E-mail', with: 'maria@leilao.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    within('nav') do
      expect(page).not_to have_button 'Sair'
      expect(page).to have_link 'Entrar como Administrador'
    end
  end
end
