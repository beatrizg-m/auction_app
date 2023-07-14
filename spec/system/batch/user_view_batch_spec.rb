# frozen_string_literal: true

require 'rails_helper'

describe 'user click in batches' do
  it 'and view future and ongoing batches' do
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25,
                 depth: 16, category_id: 1)
    Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98, height: 60,
                 depth: 0, category_id: 1)
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300,
                 width: 10, height: 20, depth: 16, category_id: 1)
    Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: 1.day.from_now, minimum_value: 200,
                  minimum_difference: 50, items: [Item.find(1)], approved: true)
    Batch.create!(code: '125bsd456', start_date: Date.new(2023, 5, 25), final_date: 1.day.from_now, minimum_value: 200,
                  minimum_difference: 50, items: [Item.find(2)], approved: true)
    Batch.create!(code: '005psd456', start_date: Date.new(2023, 5, 25), final_date: Date.today, minimum_value: 200,
                  minimum_difference: 50, items: [Item.find(2)], approved: false)

    visit root_path
    click_on 'Lotes'

    expect(page).to have_content 'Lotes futuros'
    expect(page).to have_content 'Lotes em andamento'
    expect(page).to have_content '123asd456'
    expect(page).not_to have_content '005psd456'
    expect(page).not_to have_content 'Editar Itens'
    expect(page).not_to have_content 'Aprovar'
  end

  it 'and is authenticated as admin' do
    admin = User.create(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password',
                         cpf: '79931180005')
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25,
                 depth: 16, category_id: 1)
    Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98, height: 60,
                 depth: 0, category_id: 1)
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300,
                 width: 10, height: 20, depth: 16, category_id: 1)
    Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: Date.new(2023, 5, 19),
                  minimum_value: 200, minimum_difference: 50, items: [Item.find(1)], approved: true)
    Batch.create!(code: '125bsd456', start_date: Date.new(2023, 5, 25), final_date: Date.new(2023, 5, 30),
                  minimum_value: 200, minimum_difference: 50, items: [Item.find(2)], approved: false)
    Batch.create!(code: '005psd456', start_date: Date.new(2023, 5, 25), final_date: Date.new(2023, 5, 30),
                  minimum_value: 200, minimum_difference: 50, items: [Item.find(2)], approved: false)

    login_as(admin)
    visit root_path

    click_on 'Lotes'

    expect(page).to have_content 'Editar'
    expect(page).to have_content 'Aprovar'
  end
end
