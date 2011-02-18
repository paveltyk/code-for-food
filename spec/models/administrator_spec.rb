require 'spec_helper'

describe Administrator do
  it "responds to :menus" do
    Administrator.new.should respond_to(:menus)
  end
end

