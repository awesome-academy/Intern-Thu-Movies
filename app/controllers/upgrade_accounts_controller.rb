class UpgradeAccountsController < ApplicationController
  before_action :find_user, :check_money_user, only: :update

  def update
    User.update_counters @user.id, money: Settings.premium_account
    if @user.premium!
      flash[:success] = t ".upgraded"
    else
      flash[:danger] = t ".error"
    end
    redirect_to root_url
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".not_found"
    redirect_to root_url
  end

  def check_money_user
    return if @user.money > Settings.money_account

    flash[:danger] = t ".error_money"
    redirect_to root_url
  end
end
