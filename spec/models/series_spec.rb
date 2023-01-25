# frozen_string_literal: true

require "rails_helper"

RSpec.describe Series, type: :model do
  describe "Create" do
    let(:empty) { described_class.create }

    it "Empty creation" do
      expect(described_class.new.save).to be(false)
    end

    it "Title presence validation" do
      expect(empty.errors[:title]).to include "Не предоставлено название"
    end

    it "URL presence validation" do
      expect(empty.errors[:url]).to include "Нет URL"
    end

    it "Description presence validation" do
      expect(empty.errors[:description]).to include "Нет описания"
    end

    it "Genres presence validation" do
      expect(empty.errors[:genres]).to include "Нет жанров"
    end

    it "Type presence validation" do
      expect(empty.errors[:type]).to include "Некорректный тип"
    end

    it "Title too long" do
      expect(described_class.create(title: "A" * 101).errors[:title]).to include "Название слишком длинное"
    end

    it "URL not unique" do
      described_class.new(url: "url", type: "Comics", genre_id: 1).save(validate: false)
      expect(described_class.create(url: "url").errors[:url]).to include "URL уже занят"
    end

    it "Description too long" do
      expect(described_class.create(description: "A" * 1001).errors[:description]).to include "Описание слишком длинное"
    end

    it "Too much genres" do
      expect(described_class.create(genres_list: Genre.pluck(:title)).errors[:genres])
        .to include "Выбрано более, чем 3 жанра"
    end
  end

  describe "Read" do
    it "Random item (from seed)" do
      expect(described_class.exists?).to be true
    end

    it "Thumbnail" do
      expect(described_class.first.thumbnail.attached?).to be true
    end

    it "Cover" do
      expect(described_class.first.cover.attached?).to be true
    end

    it "Cover thumb variant" do
      expect(described_class.first.cover.variant(:thumb).nil?).to be false
    end
  end

  # describe "Update" do
  # end

  def attach_random_image(size, format, target)
    name = Faker::Alphanumeric.alpha(number: 30)
    File.open("./tmp/#{name}.#{format}", "wb") do |saved_file|
      URI.parse(Faker::Avatar.image(slug: name, size:, format:)).open do |read_file|
        saved_file.write(read_file.read)
      end
    end
    target.attach(io: File.open("./tmp/#{name}.#{format}", "rb"), filename: "#{name}.#{format}")
    # target.save
    # File.delete("./tmp/#{name}.#{format}")
  end

  describe "Delete" do
    let!(:object_with_tags) do
      c = described_class.new(title: "Title one", url: "url-title-one", description: "Description of the comics",
                              user: User.first, genres_list: ["Action"], genre_id: Genre.first.id,
                              tags_list: %w[tag1 tag2 tag3], type: "Comics")
      attach_random_image("300x300", "png", c.thumbnail)
      attach_random_image("960x1440", "png", c.cover)
      c
    end

    let!(:object_with_genres) do
      c = described_class.new(title: "Title two", url: "url-title-two", description: "Description of the comics",
                              user: User.first, genres_list: ["Comedy"], genre_id: Genre.first.id,
                              tags_list: %w[tag1 tag2 tag3], type: "Comics")
      attach_random_image("300x300", "png", c.thumbnail)
      attach_random_image("960x1440", "png", c.cover)
      c
    end

    let!(:object_with_episodes) do
      c = described_class.new(title: "Title three", url: "url-title-three", description: "Description of the comics",
                              user: User.first, genres_list: ["Drama"], genre_id: Genre.first.id,
                              tags_list: %w[tag1 tag2 tag3], type: "Comics")
      attach_random_image("300x300", "png", c.thumbnail)
      attach_random_image("960x1440", "png", c.cover)
      c.save
      rand(1..10).times { ComicEpisode.new(series_id: c.id).save(validation: false) }
      c
    end

    it "Check object with tags" do
      expect(object_with_tags).not_to be_nil
    end

    it "Check object with genres" do
      expect(object_with_genres).not_to be_nil
    end

    it "Check object with episodess" do
      expect(object_with_episodes).not_to be_nil
    end

    it "Cascade tags relation" do
      expect { object_with_tags.destroy }.to change(SeriesTag, :count).by(-object_with_tags.tags.count)
    end

    it "Save tags" do
      expect { object_with_tags.destroy }.not_to change(Tag, :count)
    end

    it "Cascade genres relation" do
      expect { object_with_genres.destroy }.to change(SeriesGenre, :count).by(-object_with_genres.genres.count)
    end

    it "Save genres" do
      expect { object_with_genres.destroy }.not_to change(Genre, :count)
    end

    it "Cascade episodes relation" do
      expect { object_with_episodes.destroy }.to change(Episode, :count).by(-object_with_tags.episodes.count)
    end
  end
end
