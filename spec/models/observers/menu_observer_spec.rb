require 'spec_helper'

describe MenuObserver do
  before(:each) { MenuObserver.instance }
  let(:menu) { Menu.make! }

  describe 'after menu published' do
    it 'sends out an email' do
      expect {
        menu.publish!
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it 'does not send an email if published_at attr did not changed' do
      expect{
        menu.update_attribute :locked, true
      }.to_not change(ActionMailer::Base.deliveries, :count)
    end
  end
end

