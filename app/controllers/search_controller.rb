class SearchController < ApplicationController
  def index
    @movies = Movie.page.by_title(params[:movie]).per Settings.search
  end
end
