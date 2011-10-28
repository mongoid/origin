require "spec_helper"

describe NilClass do

  describe "#_add" do

    it "returns the object" do
      nil._add(1).should eq(1)
    end
  end

  describe "#_intersect" do

    context "when provided a non enumerable" do

      it "returns an array of the object" do
        nil._intersect(1).should eq([ 1 ])
      end
    end

    context "when provided an array" do

      it "returns the array" do
        nil._intersect([ 1, 2 ]).should eq([ 1, 2 ])
      end
    end
  end
end
