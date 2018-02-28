# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# customer = Customer.create!(name:'omar', password:'cone', email:'asd@as.com', securityNumber:1234)
# Customer.create!(name:'irving', password:'cone', email:'as1d@as.com', securityNumber:1234)
general = Customer.create!(name:'general', password:'general', email:'general@as.com', securityNumber:1234)
CustomerWallet.create!(debitcard: {"number": "1234123312341234","company": "visa"}, typewallet: "general", balance: 0, customer_id: general.id)