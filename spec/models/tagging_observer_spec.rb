require 'spec_helper'

describe TaggingObserver do
  before(:each) { TaggingObserver.instance }
  let(:dish) { Dish.make! :price => 1000}
  let(:tag) {DishTag.make! :value => 100}

  context "when tagging created" do
    it "updates dish total_price" do
      dish.tags << tag
      dish.reload.total_price.should eql 1100
    end
  end

  context "when tagging removed" do
    it "updates dish total_price" do
      dish.tags << tag
      dish.taggings.find_by_dish_tag_id(tag.id).destroy
      dish.reload.total_price.should eql 1000
    end
  end
end

