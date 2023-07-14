# frozen_string_literal: true

require 'rails_helper'

describe 'Admin create a batch' do
  it 'being authenticated' do
    admin = User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password',
                          password_confirmation: 'password', cpf: '85770404027')

    login_as(admin)
    visit root_path

    click_on 'Lotes'
    click_on 'Criar lote'

    expect(current_path).to eq new_batch_path
    expect(page).to have_content 'Crie um novo lote'
  end

  it 'successfully' do
    admin = User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password',
                          password_confirmation: 'password', cpf: '85770404027')
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25,
                 depth: 16, category_id: 1)
    Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98,
                 height: 60, depth: 0, category_id: 1)
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300,
                 width: 10, height: 20, depth: 16, category_id: 1)

    login_as(admin)
    visit root_path

    click_on 'Lotes'
    click_on 'Criar lote'
    fill_in 'Código', with: '123abc456'
    fill_in 'Data de início', with: '20/12/2023'
    fill_in 'Data final', with: '20/01/2024'
    fill_in 'Valor mínimo do lance', with: 200
    fill_in 'Diferença mínima de lance', with: 50
    find('input[value="3"]').click
    find('input[value="2"]').click
    click_on 'Criar'

    expect(page).to have_content 'Lote cadastrado esperando por aprovação.'
    expect(page).to have_button 'Aprovar'
    expect(Batch.last.items.count).to eq 2
  end

  it 'With non-standard code' do
    admin = User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password',
                          password_confirmation: 'password', cpf: '85770404027')
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25,
                 depth: 16, category_id: 1)
    Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98,
                 height: 60, depth: 0, category_id: 1)
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300,
                 width: 10, height: 20, depth: 16, category_id: 1)

    login_as(admin)
    visit root_path

    click_on 'Lotes'
    click_on 'Criar lote'
    fill_in 'Código', with: '1b456'
    fill_in 'Data de início', with: '20/12/2023'
    fill_in 'Data final', with: '20/01/2024'
    fill_in 'Valor mínimo do lance', with: 200
    fill_in 'Diferença mínima de lance', with: 50
    find('input[value="3"]').click
    find('input[value="2"]').click
    click_on 'Criar'

    expect(page).to have_content 'Não foi possível cadastrar o lote'
    expect(current_path).to eq batches_path
  end

  it 'and needs approval from another admin' do
    User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password',
                  password_confirmation: 'password', cpf: '85770404027')
    joao = User.create(email: 'joao@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password',
                        cpf: '87777471007')
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25,
                 depth: 16, category_id: 1)
    Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98, height: 60,
                 depth: 0, category_id: 1)
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300,
                 width: 10, height: 20, depth: 16, category_id: 1)
    Batch.create!(code: '005psd456', start_date: Date.new(2023, 5, 10), final_date: Date.new(2023, 5, 15),
                  minimum_value: 200, minimum_difference: 50, items: [Item.last], approved: false, created_by_id: User.last.id)

    login_as(joao)
    visit root_path

    click_on 'Lotes'
    click_on 'Aprovar'

    expect(page).to have_content 'Apenas outro administrador pode aprovar o lote'
    expect(current_path).to eq batches_path
  end

  it 'and can no longer edit after approval' do
    maria = User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password',
                          password_confirmation: 'password', cpf: '85770404027')
    User.create(email: 'joao@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password',
                 cpf: '87777471007')
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25,
                 depth: 16, category_id: 1)
    Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98, height: 60,
                 depth: 0, category_id: 1)
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300,
                 width: 10, height: 20, depth: 16, category_id: 1)
    Batch.create!(code: '005psd456', start_date: Date.new(2023, 5, 10), final_date: Date.new(2023, 5, 15),
                  minimum_value: 200, minimum_difference: 50, items: [Item.last], approved: false, created_by_id: User.last.id)

    login_as(maria)
    visit root_path

    click_on 'Lotes'
    click_on 'Aprovar'

    expect(page).to have_content 'Lote aprovado'
    expect(page).not_to have_content 'Editar Itens'
    expect(current_path).to eq batches_path
  end
end
