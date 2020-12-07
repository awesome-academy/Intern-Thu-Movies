require "rails_helper"

describe Movie, type: :model do
  let(:movie_count){Movie.count}
  let!(:genre_1){FactoryBot.create :genre}
  let!(:movie_1){FactoryBot.create :movie, title: "Mulan", director: "Niki"}
  let!(:movie_2){FactoryBot.create :movie, title: "Avengers"}

  describe "Associations" do
    [:comments, :favoriate_movies, :rates].each do |model|
      it {is_expected.to have_many(model).dependent(:destroy)}
    end

    it "belong_to genre" do
      is_expected.to belong_to :genre
    end

    it "has many users" do
      is_expected.to have_many(:users).through :favoriate_movies
    end

  end

  describe "Validates" do
    [:title, :slug, :trailer, :image].each do |v|
      it {is_expected.to validate_presence_of v}
    end
  end

  describe "Enums" do
    it "status enum" do
      is_expected.to define_enum_for(:status).with_values lock_movie: 0, open: 1
    end
  end

  describe "Scopes" do
    describe ".by_title" do
      context "when title not present" do
        it "return total movies" do
          expect(Movie.by_title(nil).count).to eq movie_count
        end
      end
      context "when title present" do
        it "return movie with title search" do
          expect(Movie.by_title("Mulan").pluck(:title)).to eq ["Mulan"]
        end
      end
    end
    describe ".by_director" do
      context "when director not present" do
        it "return total movies" do
          expect(Movie.by_director(nil).count).to eq movie_count
        end
      end
      context "when director present" do
        it "return movie with director search" do
          expect(Movie.by_director("Niki").pluck(:director)).to eq ["Niki"]
        end
      end
    end

    describe ".ordered_by_title" do
      it "order by title" do
        expect(Movie.ordered_by_title("asc").first).to eq movie_2
      end
    end
  end

  describe "#check_score" do
    subject {movie_1.check_score.blank?}
    context "when movie has been not rated yet" do
      it "return true" do
        is_expected.to eq true
      end
    end
    context "when movie was rated" do
      let!(:rate_movie_1) {FactoryBot.create :rate, movie: movie_1}
      it "return false" do
        is_expected.to eq false
      end
    end
  end

  describe "#average_score" do
    it "calculate average rating" do
      (1..5).each do |s|
        FactoryBot.create(:rate, score: s, movie: movie_1)
      end
      expect(movie_1.average_score.to_i).to eq 3*20
    end
  end
end
