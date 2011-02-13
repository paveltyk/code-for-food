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
end

