# encoding: utf-8

class BalanceController < ApplicationController
  before_filter :require_user

  def show
    @transactions_total = current_user.payment_transactions.total
    @orders_total = current_user.orders.total
    @balance = @transactions_total - @orders_total
  end
end

