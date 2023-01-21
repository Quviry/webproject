# frozen_string_literal: true

namespace :custom do
  desc "Generate genres"
  task genres: :environment do
    puts "This is actual genres:"

    ["Action", "Comedy", "Drama", "Fantasy", "Gaming", "Horror", "Mistery", "Romance", "Science fiction",
     "Slice of life"].each do |genre|
      Genre.where(title: genre).first_or_create.save
    end
    puts Genre.all.pluck(:title)
  end
end
