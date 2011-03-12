class MenusController < ApplicationController
  before_filter :require_admin
  before_filter :assign_menu, :only => [:show, :edit, :update, :lock, :publish]

  def show
    @orders = @menu.orders
  end

  def new
    @menu = current_user.menus.new(:date => params[:date])
    2.times { @menu.dishes.build }
  end

  def create
    @menu = current_user.menus.new(params[:menu])
    if @menu.save
      flash[:notice] = 'Меню создано успешно.'
      redirect_to order_path(@menu)
    else
      render :action => :new
    end
  end

  def edit
    render :action => :new
  end

  def update
    if @menu.update_attributes(params[:menu])
      flash[:notice] = 'Меню обновлено успешно.'
      redirect_to order_path(@menu)
    else
      render :action => :new
    end
  end

  def lock
    if @menu.update_attribute(:locked, true)
      flash[:notice] = 'Меню заблокировано.'
    else
      flash[:error] = 'Не удалось заблокировать меню: ' + @menu.errors.full_messages.join('; ')
    end

    redirect_to :back
  end

  def publish
    if @menu.publish!
      flash[:notice] = 'Меню опубликовано успешно.'
    else
      flash[:error] = 'Не удалось опубликовать меню: ' + @menu.errors.full_messages.join('; ')
    end

    redirect_to :back
  end

  private

  def assign_menu
    @menu = current_user.menus.find_by_date(params[:id])
  end
end

