# frozen_string_literal: true

require 'rails_helper'

describe 'user sees winning lots' do
  it 'successfully' do
    user = User.create!(email: 'roberto@gmail.com', password: '123456', password_confirmation: '123456',
                        cpf: '36328020090')
    User.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password',
                 cpf: '79931180005')
    Category.create!(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca Hello', description: 'Caneca da Hello Kitty branca', weight: 320, width: 13, height: 25,
                 depth: 16, category_id: 1)
    Item.create!(name: 'Blusa crooped', description: 'Blusa curta feita de lã roxa', weight: 16, width: 98, height: 60,
                 depth: 0, category_id: 1)
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300,
                 width: 10, height: 20, depth: 16, category_id: 1)
    Batch.create!(code: '125bsd456', start_date: Date.new(2023, 5, 25), final_date: Date.new(2023, 5, 30),
                  minimum_value: 200, minimum_difference: 50, items: [Item.find(2)], approved: false)
    Batch.create!(code: '005psd456', start_date: Date.new(2023, 5, 10), final_date: Date.new(2023, 5, 15),
                  minimum_value: 200, minimum_difference: 50, items: [Item.find(2)], approved: true, winner_id: 1)
    Bid.create(value: 300, batch_id: Batch.last.id, user_id: User.last.id)

    login_as(user)
    visit root_path

    click_on 'Lotes'
    click_on 'Lotes Vencedores'

    expect(page).to have_content 'Vencedor: roberto@gmail.com'
    expect(page).to have_content '005psd456'
  end
end
