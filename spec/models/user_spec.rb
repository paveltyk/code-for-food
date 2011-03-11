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
end

