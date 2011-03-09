class OrdersController < ApplicationController
  before_filter :require_user
  before_filter :assign_menu

  def show
    @order = current_user.orders.find_by_menu_id @menu.id
  end

  def new
    @order = current_user.orders.find_or_initialize_by_menu_id @menu.id
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

  def update
    @order = current_user.orders.find_by_menu_id @menu.id

    if @order.update_attributes(params[:order])
      flash[:notice] = 'Order updated succesfully!'
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

