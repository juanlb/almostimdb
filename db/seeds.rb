# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
  movies = Movie.create([{ title: 'Star Wars', release_year: 1977 }, { title: 'Lord of the Rings', release_year: 2001 }])
#   Character.create(name: 'Luke', movie: movies.first)
