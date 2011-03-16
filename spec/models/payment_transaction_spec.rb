require 'spec_helper'

describe PaymentTransaction do
  describe 'validation' do
    let(:payment) { PaymentTransaction.make }

    it 'valid' do
      payment.should be_valid
    end

    it 'invalid if user is blank' do
      payment.user = nil
      payment.should_not be_valid
      payment.should have_at_least(1).error_on(:user)
    end

    it 'invalid if value is greater than or equal to 1_000_000' do
      payment.value = 1_000_000
      payment.should_not be_valid
      payment.should have_at_least(1).error_on(:value)
    end

    it 'invalid if value is less than or equal to -1_000_000' do
      payment.value = -1_000_000
      payment.should_not be_valid
      payment.should have_at_least(1).error_on(:value)
    end
  end
end

