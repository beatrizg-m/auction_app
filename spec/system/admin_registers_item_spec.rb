require 'rails_helper'

describe 'Usuário cadastra item para leilão' do
  it 'estando autenticado' do
    #Arrange
    admin = Admin.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '11965580432')
    #Act
    # login_as(admin)
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'maria@leilaodogalpao.com.br'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Itens'
    click_on 'Cadastrar Itens'
    #Assert
    expect(current_path).to eq new_item_path
    expect(page).to have_content 'Cadastre os itens para o leilão'
    expect(page).not_to have_content 'Entrar'
  end

  it 'com sucesso' do
    admin = Admin.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '11965580432')
    Category.create!(name: 'Roupas', description: 'variedade de vestimentas')
    cozinha = Category.create!(name: 'Cozinha', description: 'utensilios de cozinha')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'maria@leilaodogalpao.com.br'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end
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
    expect(page).to have_content 'Nome: Caneca'
    expect(page).to have_content 'Descrição: Caneca feita de porcelana'
    expect(page).to have_content 'Peso: 10'
    expect(page).to have_content 'Largura: 20'
    expect(page).to have_content 'Altura: 25'
    expect(page).to have_content 'Profundidade: 20'
    expect(page).to have_content 'Categoria: Cozinha'
  end
end
