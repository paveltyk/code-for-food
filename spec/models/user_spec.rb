require 'spec_helper'

describe User do
  describe "#validation" do
    it "valid" do
      User.make.should be_valid
    end

    it "not valid if email is blank" do
      User.make(:email => nil).should_not be_valid
    end

    it "not valid if email does not look like an email address" do
      User.make(:email => 'bad emal').should_not be_valid
    end

    it "not valid if password is blank" do
      User.make(:password => nil).should_not be_valid
    end

    it "not valid if password is too short" do
      User.make(:password => '123').should_not be_valid
    end

    it "not valid if password confirmation does not match password" do
      User.make(:password_confirmation => 'bad confirm').should_not be_valid
    end
  end

  describe '#to_s' do
    it 'returns name if present' do
      User.make(:name => 'User Name').to_s.should eql 'User Name'
    end

    it 'returns first part of email if name is blank' do
      user = User.make
      user.to_s.should eql user.email.split('@').first
    end
  end

  describe 'orders relation' do
    let(:user) { User.make! }
    describe '#total' do
      it 'return sum of all order prices' do
        Order.destroy_all
        2.times { OrderItem.make! :order => Order.make(:user => user) }
        user.orders.total.should eql Order.sum(:price)
      end
    end
  end

  describe 'payment_transactions relation' do
    let(:user) { User.make! }
    describe '#total' do
      it 'returns sum for all payment transactions' do
        2.times { user.payment_transactions.create! :value => 100 }
        user.payment_transactions.total.should eq 200
      end

      it 'returns zero if there is no transactions' do
        user.payment_transactions.total.should eq 0
      end
    end
  end

  describe '#balance' do
    let(:user) { User.make! }
    it 'returns #payment_transactions.total - #orders.total' do
      order = Order.make! :user => user
      transaction = PaymentTransaction.make! :user => user
      user.balance.should eql(transaction.value - order.price)
    end
  end
end

