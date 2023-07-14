# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Admin.create!(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password',
              cpf: '79931180005')
Admin.create!(email: 'joao@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password',
              cpf: '85770404027')

User.create!(email: 'roberto@gmail.com', password: '123456', password_confirmation: '123456', cpf: '36328020090')
User.create!(email: 'vanessa@gmail.com', password: '123456', password_confirmation: '123456', cpf: '87777471007')

Category.create!(name: 'Cozinha', description: 'utensilios de cozinha')

Item.create!(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300,
             width: 10, height: 20, depth: 16, category_id: Category.first.id)
Item.create!(name: 'Caneca HP', description: 'Caneca do harry potter', weight: 300, width: 10, height: 20, depth: 16,
             category_id: Category.first.id)
Item.create!(name: 'Caneca HP2', description: 'Caneca do harry potter 2', weight: 300, width: 10, height: 20,
             depth: 16, category_id: Category.first.id)
Item.create!(name: 'Caneca HP3', description: 'Caneca do harry potter 3', weight: 300, width: 10, height: 20,
             depth: 16, category_id: Category.first.id)
Item.create!(name: 'Caneca HP4', description: 'Caneca do harry potter 4', weight: 300, width: 10, height: 20,
             depth: 16, category_id: Category.first.id)
Item.create!(name: 'Caneca HP5', description: 'Caneca do harry potter 5', weight: 300, width: 10, height: 20,
             depth: 16, category_id: Category.first.id)

Batch.create!(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: Date.new(2023, 5, 21),
              minimum_value: 200, minimum_difference: 50, items: [], approved: true, created_by_id: Admin.first.id, approved_by_id: Admin.last.id)
Batch.create!(code: '125bsd456', start_date: Date.new(2023, 5, 25), final_date: 1.day.from_now, minimum_value: 200,
              minimum_difference: 50, items: [Item.first], approved: true, created_by_id: Admin.last.id, approved_by_id: Admin.first.id)
Batch.create!(code: '005psd456', start_date: Date.new(2023, 5, 10), final_date: Date.today, minimum_value: 200,
              minimum_difference: 50, items: [Item.last], approved: true, created_by_id: Admin.last.id, approved_by_id: Admin.first.id)
Bid.create(value: 300, batch_id: Batch.last.id, user_id: User.last.id)
