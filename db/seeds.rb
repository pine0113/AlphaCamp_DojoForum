# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Default admin

User.create(name: "sinash", email: "pine0113@gmail.com", password: "12345678", role: "admin")
User.create(name: "admin", email: "admin@example.com", password: "12345678", role: "admin")
User.create(name: "user", email: "user@example.com", password: "12345678", role: "")

puts "Default admin created!"


Category.create(:name => "商業類")
Category.create(:name => "技術類")
Category.create(:name => "心理類")