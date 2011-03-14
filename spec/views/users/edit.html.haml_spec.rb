require 'spec_helper'

describe "users/edit.html.haml" do
  context 'when model is a new record' do
    before(:each) {assign :user, mock_model(User, :new_record? => false).as_null_object }

    it "renders name text field" do
      render
      rendered.should have_selector('input[type=text][id=user_name]')
    end

    it "renders receive notifications checkbox" do
      render
      rendered.should have_selector('input[type=checkbox][id=user_receive_notifications]')
    end
  end

  context 'when model is not a new record' do
    before(:each) {assign :user, mock_model(User, :new_record? => true).as_null_object }

    it "does not render name text field" do
      render
      rendered.should_not have_selector('input[type=text][id=user_name]')
    end

    it "does not render receive notifications checkbox" do
      render
      rendered.should_not have_selector('input[type=checkbox][id=user_receive_notifications]')
    end
  end
end

