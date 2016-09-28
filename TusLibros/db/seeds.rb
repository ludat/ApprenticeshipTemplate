# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a_user = User.create!(username: 'lucas', password: 'password')
#
Book.create! isbn: '1000000000', title: 'Don Quixote', price: 10
Book.create! isbn: '2000000000', title: 'Tale of Two Cities', price: 15
Book.create! isbn: '3000000000', title: 'The Alchemist', price: 52
Book.create! isbn: '4000000000', title: 'The Little Prince', price: 38
Book.create! isbn: '5000000000', title: 'Harry Potter and the Philosopher\'s Stone', price: 57
Book.create! isbn: '6000000000', title: 'The Hobbit', price: 102
Book.create! isbn: '7000000000', title: 'And Then There Were None', price: 12
Book.create! isbn: '8000000000', title: 'Dream of the Red Chamber', price: 74
Book.create! isbn: '9000000000', title: 'Alice in Wonderland', price: 19
