class Admin::OrdersController < Admin::BaseController
  before_filter :assign_order

  def show
  end

  def edit
  end

  def update
    @order.user = User.find_by_id(params[:order][:user_id]) if params[:order].try(:'[]', :user_id)
    if @order.update_attributes(params[:order])
      flash[:notice] = "Заказ пользователя #{@order.user} на \"#{@order.menu}\" обновлен успешно."
      redirect_to [:admin, @order]
    else
      render :action => :edit
    end
  end

  def destroy
    @order.destroy
    flash[:notice] = 'Заказ успешно удален.'
    redirect_to admin_user_path @order.user
  end

  private

  def assign_order
    @order = Order.find(params[:id])
  end
end

