class Admin::MoviesController < AdminController
  authorize_resource
  before_action :find_movie, except: %i(index create new)
  before_action :load_data, only: %i(index new edit)
  before_action :load_notify, only: :index

  def index
    @q = Movie.unscoped.ordered_by_create
              .search params[:q], auth_object: set_ransack_auth_object
    @movies = @q.result.includes(:genre).page(params[:page]).per Settings.five
  end

  def new
    @movie = Movie.unscoped.new
  end

  def create
    @movie = Movie.unscoped.new movie_params
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
      flash[:success] = t ".movie_deleted"
    else
      flash[:danger] = t ".fail"
    end
    respond_to :js
  end

  def lock
    if @movie.update status: params[:status]
      UserWorker.perform_async @movie.id
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    respond_to :js
  end

  private

  def movie_params
    params.require(:movie).permit Movie::MOVIE_PERMIT
  end

  def find_movie
    @movie = Movie.unscoped.find params[:id]
  end

  def load_data
    @genre = Genre.all
  end

  def load_notify
    @notification = Notification.unread.ordered_by_create
                                .page(params[:page]).per Settings.five
  end

  def set_ransack_auth_object
    :admin if current_user.admin?
  end
end
