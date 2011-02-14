class MenusController < ApplicationController
  def show
    @menu = Menu.find(params[:id])
  end

  def new
    @menu = Menu.new
    2.times { @menu.dishes.build }
  end

  def create
    @menu = Menu.new(params[:menu])
    if @menu.save
      redirect_to @menu, :notice => 'Menu created successfully'
    else
      render :action => :new
    end
  end

  def edit
    @menu = Menu.find(params[:id])
    render :action => :new
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update_attributes(params[:menu])
      flash[:notice] = 'Menu updated successfully'
      redirect_to @menu, :notice => 'Menu updated successfully'
    else
      render :action => :new
    end
  end
end

