require 'rails_helper'

describe 'Admin authenticates' do
  it 'successfully' do
    admin = User.create!(name: 'Maria', email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '63253417085', role: 'admin')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'Email', with: 'maria@leilaodogalpao.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      debugger
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'maria@leilaodogalpao.com.br'
      expect(page).not_to have_link 'Entrar'
    end
  end

  it "but you don't have the correct domain" do
    admin = User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '63253417085')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'Email', with: 'maria@leilao.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    within('nav') do
      expect(page).not_to have_button 'Sair'
      expect(page).to have_link 'Entrar'
    end
  end
end
