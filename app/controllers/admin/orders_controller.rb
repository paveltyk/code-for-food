class Admin::OrdersController < Admin::BaseController
  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      flash[:notice] = "Заказ пользователя #{@order.user} на \"#{@order.menu}\" обновлен успешно."
      redirect_to [:admin, @order]
    else
      render :action => :edit
    end
  end
end

