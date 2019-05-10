# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Organization.create(name: "Eden Park", description: "", city: "Bologna", home_page: "https://www.edenparkzone.it", logo_image: "edenpark.png")

Color.create(name: "blue", val: 10)
Color.create(name: "green", val: 20)
Color.create(name: "yellow", val: 30)
Color.create(name: "orange", val: 40)
Color.create(name: "purple", val: 50)
Color.create(name: "black", val: 60)

User.create(name: "Piter", email: "donapieppo121212@gmail.com", manager: true)
User.create(name: "Gas", email: "gasgasgas121212@gmail.com", manager: true)
