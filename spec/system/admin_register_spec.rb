require "rails_helper"

describe 'Usuário se cadastra' do
  it 'com sucesso' do
    visit root_path
    click_on 'Cadastrar-se'

    fill_in 'E-mail', with: 'joao@leilaodogalpao.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'CPF', with: '11965580432'
    click_on 'Inscrever-se'

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(current_path).to eq root_path
  end

  it 'com cpf já existente' do
    ad = Admin.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '11965580432')

    visit root_path
    click_on 'Cadastrar-se'

    fill_in 'E-mail', with: 'joao@leilaodogalpao.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'CPF', with: '11965580432'
    click_on 'Inscrever-se'

    expect(page).to have_content 'CPF já em uso'
    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(current_path).to eq '/admins'
    expect(page).not_to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
  end

  it 'e ocorre erro' do
    visit root_path
    click_on 'Cadastrar-se'

    fill_in 'E-mail', with: 'joao@leilao.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'CPF', with: '11965580432'
    click_on 'Inscrever-se'

    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(current_path).to eq '/admins'
  end
end
