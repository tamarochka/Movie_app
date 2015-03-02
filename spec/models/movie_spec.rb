require "rails_helper"

describe Movie do
  describe ".movie_rating" do
    before :each do
      @accountant = Movie.new(title: "The Accountant", year: "2001")
    end

    it "gets rating" do
      result = @accountant.movie_rating

      expect(result).to eq("7.9")
    end
  end
end
