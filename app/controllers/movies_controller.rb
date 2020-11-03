class MoviesController < ApplicationController
  before_action :logged_in_user, only: %i(show watch)

  def index
    @q = Movie.ransack params[:q]
    @movies = @q.result.ordered_by_view.page(params[:page]).per Settings.five
  end

  def show
    @movie = Movie.includes(:casts).find_by slug: params[:slug]
    @recommend = Genre.includes(:movies).find_by id: @movie.genre_id
  end

  def watch
    @movie = Movie.find_by slug: params[:slug]
    Movie.update_counters [@movie.id], view: Settings.movie.inc_view_per
    @comments = @movie.comments

    return if @movie

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
