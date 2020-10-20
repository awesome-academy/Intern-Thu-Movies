class BookmarkMoviesController < ApplicationController
  before_action :find_movie, only: %i(create destroy)
  before_action :find_bookmark_movie, only: :destroy

  def index
    id_bookmark = current_user.favoriate_movies.bookmark.pluck :movie_id
    @bookmark_movies = Movie.by_id(id_bookmark)
                            .page(params[:page]).per Settings.favorite
  end

  def create
    @bookmark_movie = current_user.favoriate_movies.build bookmark_movie_params

    if @bookmark_movie.save
      flash.now[:success] = t ".success"
    else
      flash.now[:danger] = t ".failed"
    end
    respond_to :js
  end

  def destroy
    if @bookmark.destroy
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

  def find_bookmark_movie
    @bookmark = current_user
                .favoriate_movies
                .find_by(movie_id: params[:movie_id],
                         typelike: params[:typelike])
    return if @bookmark

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def bookmark_movie_params
    params.permit FavoriateMovie::FAVORITE_PERMIT
  end
end
