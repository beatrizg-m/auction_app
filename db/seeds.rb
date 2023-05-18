# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Admin.create(email: 'maria@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '79931180005')
Admin.create(email: 'joao@leilaodogalpao.com.br', password: 'password', password_confirmation: 'password', cpf: '85770404027')

Category.create(name: 'Cozinha', description: 'utensilios de cozinha')

Item.create(name: 'Caneca HA', description: 'Caneca do homem aranha feita de porcelana pintada', weight: 300, width: 10, height: 20, depth: 16, category_id: 1)
Item.create(name: 'Caneca HP', description: 'Caneca do harry potter', weight: 300, width: 10, height: 20, depth: 16, category_id: 1)
Item.create(name: 'Caneca HP2', description: 'Caneca do harry potter 2', weight: 300, width: 10, height: 20, depth: 16, category_id: 1)
Item.create(name: 'Caneca HP3', description: 'Caneca do harry potter 3', weight: 300, width: 10, height: 20, depth: 16, category_id: 1)
Item.create(name: 'Caneca HP4', description: 'Caneca do harry potter 4', weight: 300, width: 10, height: 20, depth: 16, category_id: 1)
Item.create(name: 'Caneca HP5', description: 'Caneca do harry potter 5', weight: 300, width: 10, height: 20, depth: 16, category_id: 1)

Batch.create(code: '123asd456', start_date: Date.new(2023, 5, 18), final_date: Date.new(2023, 5, 19), minimum_value: 200, minimum_difference: 50, items: [Item.find(25), Item.find(28)])
