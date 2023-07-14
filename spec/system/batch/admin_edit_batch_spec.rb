# frozen_string_literal: true

require 'rails_helper'

describe 'admin edits items in a batch' do
  it 'successfully' do
    admin = User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25, depth: 16, category_id: 1)
    c1 = Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98, height: 60, depth: 0, category_id: 1)
    c2 = Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300, width: 10, height: 20, depth: 16, category_id: 1)
    Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: Date.new(2023, 5, 19), minimum_value: 200, minimum_difference: 50, items: [Item.find(1), Item.find(2)], created_by_id: admin.id)

    login_as(admin)
    visit root_path
    click_on 'Lotes'
    click_on 'Editar Itens'
    find('input[value="3"]').click
    find('input[value="2"]').click
    click_on 'Salvar'

    expect(page).to have_content '123asd456'
    expect(page).to have_content 'Caneca HA'
    expect(page).not_to have_content 'Blusa crooped'
  end

  it 'and withdraw an item' do
    admin = User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25,
                 depth: 16, category_id: 1)
    Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98,
                 height: 60, depth: 0, category_id: 1)
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300,
                 width: 10, height: 20, depth: 16, category_id: 1)
    Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: Date.new(2023, 5, 19),
                  minimum_value: 200, minimum_difference: 50, items: [Item.find(1), Item.find(2)], created_by_id: admin.id)

    login_as(admin)
    visit root_path
    click_on 'Lotes'
    click_on 'Editar Itens'
    find('input[value="2"]').click
    click_on 'Salvar'

    expect(page).to have_content '123asd456'
    expect(page).not_to have_content 'Blusa crooped'
  end

  it 'After it is approved' do
    admin = User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25,
                 depth: 16, category_id: 1)
    Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98,
                 height: 60, depth: 0, category_id: 1)
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300,
                 width: 10, height: 20, depth: 16, category_id: 1)
    Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: Date.new(2023, 5, 19),
                  minimum_value: 200, minimum_difference: 50, items: [Item.find(1), Item.find(2)], approved: true)

    login_as(admin)
    visit root_path
    click_on 'Lotes'

    expect(page).not_to have_content 'Editar Itens.'
  end

  it 'be responsible for the lot' do
    maria = User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password',
                  cpf: '79931180005')
    joao = User.create!(email: 'joao@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password',
                  cpf: '85770404027')
    batch = Batch.create!(code: '123asd456', start_date: Date.today, final_date: 1.day.from_now,
                          minimum_value: 200, minimum_difference: 50, items: [], approved: false,
                          created_by_id: maria.id)

    login_as(joao)
    visit edit_batch_path(batch.id)

    expect(current_path).to eq root_path
  end
end
