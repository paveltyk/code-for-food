class TagsController < ApplicationController

  def index
    @tags = DishTag.all
  end

  def new
    @tag = DishTag.new :value => nil
  end

  def create
    @tag = DishTag.new params[:dish_tag]
    @tag.value ||= 0

    if @tag.save
      flash[:notice] = 'Метка успешно создана.'
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
end

