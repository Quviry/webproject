# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'open-uri'

["Action", "Comedy", "Drama", "Fantasy", "Gaming", "Horror", "Mistery", "Romance", "Science fiction",
  "Slice of life"].each do |genre|
   Genre.where(title: genre).first_or_create()
end

User.create([{email: "user@example.ru", password: "password", login: "user", confirmed: false},
  {email: "confirmed_user@example.ru", password: "confirmed_password", login: "confirmed_user", confirmed: false}])

File.open("./tmp/img.png", "wb") do |saved_file|
  # the following "open" is provided by open-uri
  URI.open(Faker::Avatar.image(slug: "file1", size: "300x300", format: "png")) do |read_file|
    saved_file.write(read_file.read)
  end
end

def attach_random_image(size, format, target)
  name = Faker::Alphanumeric.alpha(number: 30)
  File.open("./tmp/#{name}.#{format}", "wb") do |saved_file|
    URI.open(Faker::Avatar.image(slug: name, size: size, format: format)) do |read_file|
      saved_file.write(read_file.read)
    end
  end
  source = File.open("./tmp/#{name}.#{format}", "rb")
  target.attach(io: source, filename: "#{name}.#{format}")
end

Comics.where(title: "Comics 1").destroy_all

c = Comics.new(title: "Comics 1", url: "Comics-1", description: "Description of the comics", user: User.first, genres_list: ["Action"], genre_id: Genre.first.id)
attach_random_image("300x300", "png", c.thumbnail)
attach_random_image("960x1440", "png", c.cover)

unless c.save
  p c.errors
end

