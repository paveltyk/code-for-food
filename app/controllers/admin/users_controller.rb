class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @orders = @user.orders.joins(:menu).includes(:menu).order('date ASC')
  end
end

