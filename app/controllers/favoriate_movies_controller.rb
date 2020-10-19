class FavoriateMoviesController < ApplicationController
  before_action :find_movie, only: %i(create destroy)
  before_action :find_favoriate_movie, only: :destroy

  def index
    id_favorite = current_user.favoriate_movies.favoriate.pluck :movie_id
    @favoriate_movies = Movie.by_id(id_favorite)
                             .page(params[:page]).per Settings.favorite
  end

  def create
    @favorite_movie = current_user
                      .favoriate_movies
                      .new(movie_id: params[:movie_id], typelike: params[:type])

    if @favorite_movie.save
      respond_to :js
    else
      redirect_to root_path
    end
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
                 .favoriate_movies
                 .find_by movie_id: params[:movie_id], typelike: params[:type]
    return if @favoriate

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
