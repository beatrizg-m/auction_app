require 'rails_helper'

describe 'Admin create a batch' do
  it 'being authenticated' do
    admin = Admin.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'maria@leilaodogalpao.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Lotes'
    click_on 'Criar lote'

    expect(current_path).to eq new_batch_path
    expect(page).to have_content 'Crie um novo lote'
  end

  it 'successfully' do
    admin = Admin.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25, depth: 16, category_id: 1)
    c1 = Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98, height: 60, depth: 0, category_id: 1)
    c2 = Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300, width: 10, height: 20, depth: 16, category_id: 1)

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'maria@leilaodogalpao.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Lotes'
    click_on 'Criar lote'
    fill_in 'Codigo', with: '123abc456'
    fill_in 'Data de início', with: '20/12/2023'
    fill_in 'Data final', with: '20/01/2024'
    fill_in 'Valor mínimo do lance', with: 200
    fill_in 'Diferença mínima de lance', with: 50
    find('input[value="3"]').click
    find('input[value="2"]').click
    click_on 'Criar'

    expect(page).to have_content 'Lote cadastrado esperando por aprovação.'
    expect(Batch.last.items.count).to eq 2
  end


end
