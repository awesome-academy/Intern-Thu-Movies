class RatesController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :find_movie, only: %i(create destroy)
  before_action :find_movie_rated, only: :destroy

  def create
    @rate_movie = current_user.rates.build rated_movie_params

    if @rate_movie.save
      flash.now[:success] = t ".success"
    else
      flash.now[:danger] = t ".failed"
    end
  end

  def destroy
    if @movie_rated.destroy
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

  def find_movie_rated
    @movie_rated = current_user.rates.find_by movie_id: params[:movie_id]

    return if @movie_rated

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def rated_movie_params
    params.permit Rate::RATE_PERMIT
  end
end
