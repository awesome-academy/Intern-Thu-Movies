class FavoriateMoviesController < ApplicationController
  before_action :find_movie, only: %i(create destroy)
  before_action :find_favoriate_movie, only: :destroy

  def index
    @favoriate_movies = current_user.movies.page.per Settings.favoriate
  end

  def create
    current_user.favoriate_movies.create(movie_id: params[:movie_id])
    respond_to :js
  end

  def destroy
    if @favoriate.destroy
      respond_to :js
    else
      flash[:danger] = t ".error"
      redirect_to root_path
    end
  end

  private

  def find_movie
    @movie = Movie.find_by id: params[:movie_id]
    return if @movie

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def find_favoriate_movie
    @favoriate = current_user
                .favoriate_movies.find_by movie_id: params[:movie_id]
    return if  @favoriate

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
