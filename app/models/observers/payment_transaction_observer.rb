# encoding: utf-8

class PaymentTransactionObserver < ActiveRecord::Observer
  observe PaymentTransaction

  def after_create(payment_transaction)
    payment_transaction.user.sweep_cached_totals
  end
end

