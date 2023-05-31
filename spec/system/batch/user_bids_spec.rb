require 'rails_helper'

describe 'User tries to bid' do
  it 'successfully' do
    User.create!(email: 'vanessa@gmail.com', password: '123456', password_confirmation: '123456', cpf: '87777471007')
    Admin.create(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '79931180005')
    Admin.create(email: 'joao@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')
    Category.create!(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300, width: 10, height: 20, depth: 16, category_id: Category.first.id)
    Item.create!(name: 'Caneca HP', description: 'Caneca do harry potter', weight: 300, width: 10, height: 20, depth: 16, category_id: Category.first.id)
    Batch.create!(code: '125bsd456', start_date: Date.new(2023, 5, 17), final_date: 1.day.from_now, minimum_value: 200, minimum_difference: 50, items: [Item.first], approved: true, created_by_id: Admin.last.id, approved_by_id: Admin.first.id)
    Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: 1.day.from_now, minimum_value: 200, minimum_difference: 50, items: [], approved: true, created_by_id: Admin.first.id, approved_by_id: Admin.last.id)

    visit root_path
    click_on 'Entrar como usuario'
    fill_in 'Email', with: 'vanessa@gmail.com'
    fill_in 'Senha', with: '123456'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Lotes'
    click_on '125bsd456'
    fill_in 'Valor', with: 900
    click_on 'Enviar lance'

    expect(page).to have_content 'Lance enviado com sucesso'
  end

  it "and can't bid" do
    Admin.create(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '79931180005')
    Admin.create(email: 'joao@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')
    Category.create!(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300, width: 10, height: 20, depth: 16, category_id: Category.first.id)
    Item.create!(name: 'Caneca HP', description: 'Caneca do harry potter', weight: 300, width: 10, height: 20, depth: 16, category_id: Category.first.id)
    Batch.create!(code: '125bsd456', start_date: Date.new(2023, 5, 20), final_date: 1.day.from_now, minimum_value: 200, minimum_difference: 50, items: [Item.first], approved: true, created_by_id: Admin.last.id, approved_by_id: Admin.first.id)
    Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: Date.new(2023, 5, 21), minimum_value: 200, minimum_difference: 50, items: [], approved: true, created_by_id: Admin.first.id, approved_by_id: Admin.last.id)

    visit root_path
    click_on 'Lotes'
    click_on '125bsd456'

    expect(page).to have_content 'Data de início: 2023-05-20'
    expect(page).not_to have_field 'value', type: 'number'
  end

  it "but the bid is declined" do
    User.create!(email: 'vanessa@gmail.com', password: '123456', password_confirmation: '123456', cpf: '87777471007')
    Admin.create(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '79931180005')
    Admin.create(email: 'joao@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')
    Category.create!(name: 'Cozinha', description: 'utensilios de cozinha')
    Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300, width: 10, height: 20, depth: 16, category_id: Category.first.id)
    Item.create!(name: 'Caneca HP', description: 'Caneca do harry potter', weight: 300, width: 10, height: 20, depth: 16, category_id: Category.first.id)
    Batch.create!(code: '125bsd456', start_date: Date.new(2023, 5, 17), final_date: 1.day.from_now, minimum_value: 200, minimum_difference: 50, items: [Item.first], approved: true, created_by_id: Admin.last.id, approved_by_id: Admin.first.id)
    Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: Date.new(2023, 5, 21), minimum_value: 200, minimum_difference: 50, items: [], approved: true, created_by_id: Admin.first.id, approved_by_id: Admin.last.id)

    visit root_path
    click_on 'Entrar como usuario'
    fill_in 'Email', with: 'vanessa@gmail.com'
    fill_in 'Senha', with: '123456'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Lotes'
    click_on '125bsd456'
    fill_in 'Valor', with: 150
    click_on 'Enviar lance'


    expect(page).to have_content 'Lance recusado'
  end

end
