class MoviesController < ApplicationController
  def index
    @movies = Movie.page params[:page]
  end

  def show
    @movie = Movie.includes(:casts).find_by slug: params[:slug]
    @recommend = Genre.includes(:movies).find_by id: @movie.genre_id
  end
end
