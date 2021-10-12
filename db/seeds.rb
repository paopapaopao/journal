# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.create(
  email: 'testuser@example.com',
  password: :password
)
c = Category.create(
  title: 'Category Title',
  description: 'Lorem ipsum dolor sit amet',
  user_id: u.id
)
t = Task.create(
  description: 'Lorem ipsum dolor sit amet',
  due_date: DateTime.now,
  status: :unfinished,
  user_id: u.id,
  category_id: c.id
)
