# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Company.destroy_all
# User.destroy_all

c = Company.create!(name: "WeRes")
puts "#{c.id}"

u = User.create!(first_name: "Julie", last_name: "Ehrmann", email: "julie.ehrmann@weres.com", company_id: c.id, password: "julieweres", company_admin: true)
u2 = User.create!(first_name: "Federico", last_name: "Volonteri", email: "federico.volonteri@weres.com", company_id: c.id, password: "federicoweres", company_admin: true)
u3 = User.create!(first_name: "Leslie", last_name: "Maarek", email: "leslie.maarek@weres.com", company_id: c.id, password: "leslieweres", company_admin: true)
u4 = User.create!(first_name: "Benjamin", last_name: "Lambrou", email: "benjamin.lambrou@weres.com", company_id: c.id, password: "benjaminweres", company_admin: true)


puts "#{c}, #{u}, #{u2}, #{u3} and #{u4} were created !"
