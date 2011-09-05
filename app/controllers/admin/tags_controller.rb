# encoding: utf-8

class Admin::TagsController < Admin::BaseController
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

  def edit
    @tag = DishTag.find(params[:id])
    render :action => :new
  end

  def update
    @tag = DishTag.find(params[:id])

    if @tag.update_attributes(params[:dish_tag])
      flash[:notice] = 'Метка успешно обновлена.'
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
end

