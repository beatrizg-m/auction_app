require "rails_helper"

describe 'Usuário se cadastra' do
  it 'com sucesso' do
    Admin.create!(email: 'joao@leilaodogalpao.com.br', senha: 'password', cpf: '11965580432')

    visit root_path
    click_on 'Cadastrar-se'
    fill_in 'E-mail', with: 'joao@leilaodogalpao.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'CPF', with: '11965580432'
    click_on 'Cadastrar'

    expect(page).to have_content 'Cadastro realizado com sucesso'
    expect(current_path).to eq 'root_path'
  end

  # it 'e ocorre erro' do
  #   User.create!(email: 'joao@email.com.br', senha: 'password', cpf: '11965580000')

  # end
end
