# encoding: utf-8

class BalanceController < ApplicationController
  before_filter :require_user

  def show
    @transactions_total = current_user.payment_transactions_total
    @orders_total = current_user.orders_total
    @balance = current_user.balance
  end
end

