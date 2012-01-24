require "spec_helper"

describe NilClass do

  describe "#_add" do

    it "returns the object" do
      nil._add(1).should eq(1)
    end
  end

  describe "#_intersect" do

    context "when provided a non enumerable" do

      it "returns the object" do
        nil._intersect(1).should eq(1)
      end
    end

    context "when provided an array" do

      it "returns the array" do
        nil._intersect([ 1, 2 ]).should eq([ 1, 2 ])
      end
    end

    context "when provided a hash" do

      it "returns the hash" do
        nil._intersect({ "$in" => [ 1, 2 ] }).should eq(
          { "$in" => [ 1, 2 ] }
        )
      end
    end
  end

  describe "#_union" do

    context "when provided a non enumerable" do

      it "returns the object" do
        nil._union(1).should eq(1)
      end
    end

    context "when provided an array" do

      it "returns the array" do
        nil._union([ 1, 2 ]).should eq([ 1, 2 ])
      end
    end

    context "when provided a hash" do

      it "returns the hash" do
        nil._union({ "$in" => [ 1, 2 ] }).should eq(
          { "$in" => [ 1, 2 ] }
        )
      end
    end
  end
end
