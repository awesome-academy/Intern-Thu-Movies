class SearchController < ApplicationController
  def index
    @q = Movie.ransack params[:q]
    @movies = @q.result.page(params[:page]).per Settings.five
  end
end
