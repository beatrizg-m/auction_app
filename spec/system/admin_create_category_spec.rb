require 'rails_helper'

describe 'Admin cria uma categoria' do
  it 'com sucesso' do
    admin = Admin.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')

    login_as(admin)
    visit root_path

    click_on 'Categorias'
    click_on 'Criar nova categoria'
    fill_in 'Nome', with: 'Cozinha'
    fill_in 'Descrição', with: 'Utensilios para cozinha'
    click_on 'Criar'

    expect(page).to have_content 'Categoria criada com sucesso'
    expect(current_path).to eq categories_path
    expect(page).to have_content 'Categoria: Cozinha'
    expect(page).to have_content 'Descrição: Utensilios para cozinha'
    expect(page).not_to have_content 'Não há categorias cadastradas.'
  end

  it 'mas falha ao tentar criar sem um dos campos' do
    admin = Admin.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')

    login_as(admin)
    visit root_path

    click_on 'Categorias'
    click_on 'Criar nova categoria'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: 'Utensilios para cozinha'
    click_on 'Criar'

    expect(page).to have_content 'Não foi possivél criar categoria'
    expect(page).not_to have_content 'Categoria criada com sucesso'
  end
end
