# frozen_string_literal: true

require 'rails_helper'

describe 'Admin registers item for auction' do
  it 'being authenticated' do
    admin = User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password',
                         password_confirmation: 'password', cpf: '85770404027')

    login_as(admin)
    visit root_path

    click_on 'Itens'
    click_on 'Cadastrar Itens'

    expect(current_path).to eq new_item_path
    expect(page).to have_content 'Cadastre os itens para o leilão'
    expect(page).not_to have_content 'Entrar'
  end

  it 'successfully' do
    admin = User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password',
                         password_confirmation: 'password', cpf: '85770404027')
    Category.create!(name: 'Roupas', description: 'variedade de vestimentas')
    Category.create!(name: 'Cozinha', description: 'utensilios de cozinha')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDE12345')

    login_as(admin)
    visit root_path

    click_on 'Itens'
    click_on 'Cadastrar Itens'
    fill_in 'Nome', with: 'Caneca'
    fill_in 'Descrição', with: 'Caneca feita de porcelana'
    fill_in 'Peso', with: '10'
    fill_in 'Largura', with: '20'
    fill_in 'Altura', with: '25'
    fill_in 'Profundidade', with: '20'
    select 'Cozinha', from: 'Categoria'
    click_on 'Criar'

    expect(page).to have_content 'Item cadastrado com sucesso'
    expect(page).to have_content 'Codigo: ABCDE12345'
    expect(page).to have_content 'Nome: Caneca'
    expect(page).to have_content 'Descrição: Caneca feita de porcelana'
    expect(page).to have_content 'Peso: 10'
    expect(page).to have_content 'Dimensões: 20cm X 25cm X 20cm'
    expect(page).to have_content 'Categoria: Cozinha'
  end
end
