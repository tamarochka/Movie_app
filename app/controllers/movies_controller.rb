class MoviesController < ApplicationController
  def index
    @movies = Movie.order('rating DESC').page(params[:page])
  end

  def upload
    if params[:file].nil?
      flash[:notice] = "Please attach file"
    else
      Movie.delay.upload(params[:file].path)
      flash[:notice]= "Importing movies"
    end
    redirect_to root_url
  end
end
