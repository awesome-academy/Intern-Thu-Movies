class BookmarkMoviesController < ApplicationController
  before_action :find_movie, only: %i(create destroy)
  before_action :find_bookmark_movie, only: :destroy

  def index
    id_bookmark = current_user.favoriate_movies.bookmark.pluck :movie_id
    @bookmark_movies = Movie.by_id(id_bookmark)
                            .page(params[:page]).per Settings.favorite
  end

  def create
    @bookmark_movie = current_user
                      .favoriate_movies
                      .new(movie_id: params[:movie_id], typelike: params[:type])

    if @bookmark_movie.save
      respond_to :js
    else
      redirect_to root_path
    end
  end

  def destroy
    if @bookmark.destroy
      respond_to :js
    else
      flash[:danger] = t ".error"
      redirect_to root_path
    end
  end

  private

  def find_movie
    @movie = Movie.find params[:movie_id]
  end

  def find_bookmark_movie
    @bookmark = current_user
                .favoriate_movies
                .find_by movie_id: params[:movie_id], typelike: params[:type]
    return if @bookmark

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
