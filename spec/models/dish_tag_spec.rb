require 'spec_helper'

describe DishTag do
  it "valid" do
    DishTag.make.should be_valid
  end

  it "set default value attr value to 0" do
    DishTag.make.value.should eql(0)
  end

  it "not valid if name is blank" do
    DishTag.make(:name => nil).should_not be_valid
  end

  it "not valid if value set to not valid integer value" do
    DishTag.make(:value => 'abc').should_not be_valid
    DishTag.make(:value => 10.6).should_not be_valid
  end

  it "not valid if value out of range" do
    DishTag.make(:value => 100_001).should_not be_valid
    DishTag.make(:value => -100_001).should_not be_valid
  end

  describe "many-to-many relation with Dish" do
    let(:dish) { Dish.make! }
    let(:tag) { DishTag.make! }

    it "adds new dish to dish list" do
      expect { tag.dishes << dish }.to change(tag.dishes, :count).from(0).to(1)
    end

    it "don't add same dish twice" do
      expect { 2.times { tag.dishes << dish } }.to change(tag.dishes, :count).from(0).to(1)
    end
  end

  describe '#name_for_collection_select' do
    it 'returns name + value' do
      dish = DishTag.make(:name => 'name', :value => '100')
      dish.name_for_collection_select.should eql "name (100)"
    end
  end

  describe 'named scope operational' do
    it 'return only operational tags' do
      DishTag.destroy_all
      DishTag.make! :operational => false
      operational_tag = DishTag.make!
      DishTag.operational.all.should eql [operational_tag]
    end
  end
end

