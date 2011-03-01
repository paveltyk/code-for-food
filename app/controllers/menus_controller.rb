class MenusController < ApplicationController
  before_filter :require_admin

  def show
    @menu = current_user.menus.find(params[:id])
  end

  def new
    @menu = current_user.menus.new(:date => params[:date])
    2.times { @menu.dishes.build }
  end

  def create
    @menu = current_user.menus.new(params[:menu])
    if @menu.save
      flash[:notice] = 'Меню создано успешно.'
      redirect_to new_order_path(@menu)
    else
      render :action => :new
    end
  end

  def edit
    @menu = current_user.menus.find_by_date(params[:id])
    render :action => :new
  end

  def update
    @menu = current_user.menus.find_by_date(params[:id])
    if @menu.update_attributes(params[:menu])
      flash[:notice] = 'Меню обновлено успешно.'
      redirect_to new_order_path(@menu)
    else
      render :action => :new
    end
  end
end

