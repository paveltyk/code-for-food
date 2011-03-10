require 'spec_helper'

describe Administrator do
  it "responds to :menus" do
    Administrator.new.should respond_to(:menus)
  end

  describe '#model_name' do
    it 'returns User#model_name' do
      Administrator.model_name.should eql User.model_name
    end
  end
end

