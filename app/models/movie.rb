class Movie < ActiveRecord::Base
  validates :title, presence: true
  paginates_per 25

  def connect_api
    query = "http://www.omdbapi.com/?t=#{self.title}&y=#{self.year}&plot=short&r=json"
    result = JSON.parse(Net::HTTP.get(URI.parse(URI.escape(query))))
  end

  def no_errors?
    connect_api["response"] != "error"
  end

  def movie_rating
   connect_api["imdbRating"]
  end

  def self.upload(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      movie = find_by_id(row["id"]) || new
      movie.attributes = row.to_hash.slice(*row.to_hash.keys)
      if movie.no_errors?
        movie.rating = movie.movie_rating.to_f
      else
        movie.rating= 0
      end
      movie.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file)
    when ".csv" then Roo::CSV.new(file)
    when ".xls" then Roo::Excel.new(file)
    when ".xlsx" then Roo::Excelx.new(file)
    else raise "Unknown file type: #{file}"
    end
  end
end
