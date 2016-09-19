# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a_user = User.create!(username: 'lucas', password: 'password')
#
# a_book = Book.create!(isbn: '123456789', title: 'The alchemist', price: 10)
# another_book = Book.create!(isbn: '987654321', title: 'LOTR', price: 25)
#
# cart = Cart.create!(user: a_user)
#
# cart.add a_book, 3
# cart.add another_book, 1
