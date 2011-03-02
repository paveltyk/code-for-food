require 'spec_helper'

describe DishTagObserver do
  before(:each) { DishTagObserver.instance }
  let(:dish) { Dish.make! :price => 1000 }
  let(:tag) {DishTag.make! :value => 100 }

  it "updates dish total price" do
    dish.tags << tag
    tag.update_attribute :value, 1000
    dish.reload.total_price.should eql 2000
  end
end

