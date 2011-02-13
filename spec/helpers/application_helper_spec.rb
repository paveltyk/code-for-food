require 'spec_helper'

describe ApplicationHelper do
  describe "#render_errors_for" do
    it "should return 2 paragraps with error messages" do
      model = double('model')
      model.stub_chain(:errors, :full_messages).and_return(['Error 1', 'Error 2'])
      helper.render_errors_for(model).should match /<p[^>]*>Error 1<\/p><p[^>]*>Error 2<\/p>/i
    end
  end
end

