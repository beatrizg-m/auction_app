require 'rails_helper'

describe 'User register' do

  it 'with existing CPF' do
    user = User.create!(email: 'maria@gmail.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')

    visit root_path
    click_on 'Cadastrar-se'
    fill_in 'Email', with: 'joao@gmail.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'CPF', with: '85770404027'
    click_on 'Inscrever-se'

    expect(page).to have_content 'CPF já esta em uso'
    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(current_path).to eq '/users'
    expect(page).not_to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
  end

  it 'successfully' do

    visit root_path
    click_on 'Cadastrar-se'
    fill_in 'Email', with: 'joao@gmail.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'CPF', with: '85770404027'
    click_on 'Inscrever-se'

    expect(page).not_to have_content 'CPF já esta em uso'
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(current_path).to eq root_path
  end

end
