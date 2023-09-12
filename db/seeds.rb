# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

today = Time.zone.today
days = ((today - 1.weeks)..today).to_a

10.times do |i|
  user = User.new(name: "user#{i}")

  10.times do |j|
    user.books << Book.new(name: "book#{j}", purchase_on: days.sample)
  end
  user.save!
end
