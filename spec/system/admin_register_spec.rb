require "rails_helper"

describe 'Usuário se cadastra' do
  it 'com sucesso' do
    visit root_path
    click_on 'Cadastrar-se'
    fill_in 'Email', with: 'joao@leilaodogalpao.com.br'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'Cpf', with: '11965580432'
    click_on 'Inscrever-se'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

  # it 'e ocorre erro' do
  #   User.create!(email: 'joao@email.com.br', senha: 'password', cpf: '11965580000')

  # end
end
