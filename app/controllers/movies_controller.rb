class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def upload
    if params[:file].nil?
      flash[:notice] = "Please attach file"
    else
      Movie.upload(params[:file])
      flash[:notice]= "Movies successfully uploaded"
    end
    redirect_to root_url
  end
end
