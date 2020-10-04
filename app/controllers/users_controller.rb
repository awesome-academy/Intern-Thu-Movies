class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".welcome"
      redirect_to root_path
    else
      flash.now[:danger] = ".error"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PERMIT
  end
end
