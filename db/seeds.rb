# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
  sw = Movie.create(title: 'Star Wars', release_year: 1977 )
  lotr = Movie.create(title: 'Lord of the Rings', release_year: 2001)

  hf = Person.create(last_name: 'Ford', first_name: 'Harrison', aliases: 'Han Solo, Indiana Jones')
  im = Person.create(last_name: 'McKellen', first_name: 'Ian', aliases: 'Gandalf, Magneto')
#   Character.create(name: 'Luke', movie: movies.first)


Direction.create(movie: sw, person: hf)
Direction.create(movie: lotr, person: hf)

Production.create(movie: sw, person: im)

Cast.create(movie: sw, person: hf)