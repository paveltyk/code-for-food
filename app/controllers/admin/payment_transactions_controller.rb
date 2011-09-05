# encoding: utf-8

class Admin::PaymentTransactionsController < Admin::BaseController
  before_filter :assign_user

  def index
    @payment_transactions = @user.payment_transactions.all
  end

  def new
    @payment_transaction = @user.payment_transactions.build
  end

  def edit
    @payment_transaction = @user.payment_transactions.find(params[:id])
  end

  def create
    @payment_transaction = @user.payment_transactions.build(params[:payment_transaction])

    if @payment_transaction.save
      flash[:notice] = 'Транзакция успешно добавлена.'
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def update
    @payment_transaction = @user.payment_transactions.find(params[:id])

    if @payment_transaction.update_attributes(params[:payment_transaction])
      flash[:notice] = 'Транзакция успешно обновлена.'
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    @payment_transaction = @user.payment_transactions.find(params[:id])
    @payment_transaction.destroy

    redirect_to :action => :index
  end

  private

  def assign_user
    @user = User.find(params[:user_id])
  end
end

