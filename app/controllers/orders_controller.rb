class OrdersController < ApplicationController
  before_filter :require_user
  before_filter :assign_menu

  def new
    @order = current_user.orders.build :menu => @menu
  end

  def create
    @order = current_user.orders.new params[:order]
    @order.menu = @menu

    if @order.save
      flash[:notice] = 'Order created succesfully!'
      redirect_to :action => :new
    else
      render :action => :new
    end
  end

  private

  def assign_menu
    @menu = Menu.find_by_date params[:date]
  end
end

