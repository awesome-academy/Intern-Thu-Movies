class FavoriateMoviesController < ApplicationController
  before_action :find_movie, only: %i(create destroy)
  before_action :find_favoriate_movie, only: :destroy

  def index
    id_favorite = current_user.favoriate_movies.favoriate.pluck :movie_id
    @favoriate_movies = Movie.by_id(id_favorite)
                             .page(params[:page]).per Settings.favorite
  end

  def create
    @favorite_movie = current_user.favoriate_movies.build favorite_movie_params

    if @favorite_movie.save
      flash.now[:success] = t ".success"
    else
      flash.now[:danger] = t ".failed"
    end
    respond_to :js
  end

  def destroy
    if @favoriate.destroy
      flash.now[:success] = t ".success"
    else
      flash.now[:danger] = t ".failed"
    end
    respond_to :js
  end

  private

  def find_movie
    @movie = Movie.find params[:movie_id]
  end

  def find_favoriate_movie
    @favoriate = current_user
                 .favoriate_movies
                 .find_by(movie_id: params[:movie_id],
                          typelike: params[:typelike])
    return if @favoriate

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def favorite_movie_params
    params.permit FavoriateMovie::FAVORITE_PERMIT
  end
end
