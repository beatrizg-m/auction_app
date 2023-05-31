require 'rails_helper'

describe 'user sees details of a batch' do
  it 'through details page' do
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25, depth: 16, category_id: 1)
    Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98, height: 60, depth: 0, category_id: 1)
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300, width: 10, height: 20, depth: 16, category_id: 1)
    Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: 1.day.from_now, minimum_value: 200, minimum_difference: 50, items: [Item.find(1)], approved: true)

    visit root_path
    click_on 'Lotes'
    click_on '123asd456'

    expect(page).to have_content 'Detalhes do lote'
    expect(page).to have_content 'Data de início: 2023-05-18'
    expect(page).to have_content 'Dimensões: 13cm X 25cm X 16cm'
    expect(page).not_to have_content 'Blusa crooped'
    expect(page).not_to have_content 'Caneca HA'
  end

  it 'and is authenticated as a user' do
    User.create(name: 'Roberto', email: 'roberto@gmail.com', password: '123456', password_confirmation: '123456', cpf: '36328020090')
    Category.create(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25, depth: 16, category_id: 1)
    Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98, height: 60, depth: 0, category_id: 1)
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300, width: 10, height: 20, depth: 16, category_id: 1)
    Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: 1.day.from_now, minimum_value: 200, minimum_difference: 50, items: [Item.find(1)], approved: true)

    visit root_path
    click_on 'Entrar como usuario'
    fill_in 'Email', with: 'roberto@gmail.com'
    fill_in 'Senha', with: '123456'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Lotes'
    click_on '123asd456'

    expect(page).to have_field 'value', type: 'number'
    expect(page).to have_button 'Enviar lance'
  end

end
