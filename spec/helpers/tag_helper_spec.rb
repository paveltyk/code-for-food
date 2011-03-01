require "spec_helper"

describe TagHelper do
  describe "#render_tags" do
    it "renders 2 spans" do
      helper.render_tags([DishTag.make, DishTag.make]).scan(/<\/span>/).should have(2).items
    end
  end
end

