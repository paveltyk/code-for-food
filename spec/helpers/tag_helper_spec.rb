require "spec_helper"

describe TagHelper do
  describe "#render_tags" do
    it "renders 2 spans" do
      helper.render_tags([DishTag.make, DishTag.make]).scan(/<\/span>/).should have(2).items
    end

    it "renders price with sign (minus)" do
      helper.render_tags([DishTag.make :value => -100, :name => 'Hello']).should match(/Hello -100/i)
    end

    it "renders price with sign (plus)" do
      helper.render_tags([DishTag.make :value => 100, :name => 'Hello']).should match(/Hello \+100/i)
    end
  end
end

