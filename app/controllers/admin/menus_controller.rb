class Admin::MenusController < Admin::BaseController
  before_filter :assign_menu, :only => [:show, :edit, :update, :lock, :publish]

  def show
    @orders = @menu.orders.includes(:user, :order_items => :dish)
    @orders.sort!{ |a, b| a.user.screen_name <=> b.user.screen_name }
    @total_price = @orders.inject(0) { |sum, order| sum + order.price }
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
    if params[:menu][:dishes_attributes]
      params[:menu][:dishes_attributes].each_value { |d| d[:tag_ids] ||= [] }
    end

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

