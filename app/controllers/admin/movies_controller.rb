class Admin::MoviesController < AdminController
  before_action :find_movie, except: %i(index create new)
  before_action :load_data, only: %i(index new edit)

  def index
    @movies = Movie.page params[:page]
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    if @movie.save
      flash[:success] = ".success"
      redirect_to admin_movies_path
    else
      flash.now[:danger] = ".error"
      render :new
    end
  end

  def edit; end

  def update
    if @movie.update movie_params
      flash[:success] = ".movie_updated"
      redirect_to admin_movies_path
    else
      flash[:danger] = t ".movie_update_fail"
      render :edit
    end
  end

  def destroy
    if @movie.destroy
      flash[:success] = t ".destroy.movie_deleted"
    else
      falsh[:danger] = t ".destroy.fail"
    end
    redirect_to admin_movies_path
  end

  private

  def movie_params
    params.require(:movie).permit Movie::MOVIE_PERMIT
  end

  def find_movie
    @movie = Movie.find_by id: params[:id]
    return if @movie

    flash[:danger] = t ".new.not_found"
    redirect_to root_admin_path
  end

  def load_data
    @genre = Genre.all
  end
end
