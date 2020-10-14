class MoviesController < ApplicationController
  before_action :logged_in_user, only: :watch

  def index
    @movies = Movie.page params[:page]
  end

  def show
    @movie = Movie.includes(:casts).find_by slug: params[:slug]
    @recommend = Genre.includes(:movies).find_by id: @movie.genre_id
  end

  def watch
    @movie = Movie.find_by slug: params[:slug]
    @comments = @movie.comments
    return if @movie

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
