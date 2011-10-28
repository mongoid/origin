require "spec_helper"

describe NilClass do

  describe "#_add" do

    it "returns the object" do
      nil._add(1).should eq(1)
    end
  end
end
