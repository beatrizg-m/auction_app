require 'rails_helper'

describe 'user searches for a batch' do
  it 'and must be authenticated' do
    user = User.create(name: 'Roberto', email: 'roberto@gmail.com', password: '123456',
                      password_confirmation: '123456', cpf: '36328020090')

    login_as(user, :scope => :user)
    visit root_path

    within('header nav') do
      expect(page).to have_field('Buscar Lote')
      expect(page).to have_button('Buscar')
    end
  end

  it 'and find a lot' do
    admin = Admin.create!(email: 'maria@leilaodogalpao.com.br', password: 'password',
                          password_confirmation: 'password', cpf: '79931180005')
    batch = Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: Date.new(2023, 5, 21),
                          minimum_value: 200, minimum_difference: 50, items: [], approved: true,
                          created_by_id: admin, approved_by_id: Admin.last.id)
    user = User.create(name: 'Roberto', email: 'roberto@gmail.com', password: '123456',
                      password_confirmation: '123456', cpf: '36328020090')

    login_as(user, :scope => :user)
    visit root_path
    fill_in 'Buscar Lote', with: batch.code
    click_on 'Buscar'

    expect(page).to have_content '1 lote encontrado'
    expect(page).to have_content "Código: #{batch.code}"
    within('header nav') do
      expect(page).to have_field('Buscar Lote')
      expect(page).to have_button('Buscar')
    end
  end


end
