require 'spec_helper'

describe ApplicationHelper do
  describe "#full_title" do
    it "returns the instance variable" do
      expect(helper.full_title("My Title")).to match(/TeaShop | My Title/)
      expect(helper.full_title("")).to match(/TeaShop/)
    end
  end
end
