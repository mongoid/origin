require "spec_helper"

describe Array do

  describe "#_add" do

    context "when the other object is a non-enumerable" do

      context "when all values are unique" do

        it "returns an array of both" do
          [ 5, 6 ]._add(7).should eq([ 5, 6, 7 ])
        end
      end

      context "when values are not unique" do

        it "returns a unique array of both" do
          [ 5, 6 ]._add(6).should eq([ 5, 6 ])
        end
      end
    end

    context "when the other object is an array" do

      context "when all values are unique" do

        it "returns an array of both" do
          [ 4, 5 ]._add([ 6, 7 ]).should eq([ 4, 5, 6, 7 ])
        end
      end

      context "when values are not unique" do

        it "returns a unique array of both" do
          [ 4, 5 ]._add([ 5, 6, 7 ]).should eq([ 4, 5, 6, 7 ])
        end
      end
    end

    context "when the other object is a hash" do

      pending "raises an error"
    end
  end

  describe "#_intersect" do

    context "when the other object is a non-enumerable" do

      context "when the values intersect" do

        it "returns an intersected array" do
          [ 5, 6, 7 ]._intersect(6).should eq([ 6 ])
        end
      end

      context "when the values do not intersect" do

        it "returns an empty array" do
          [ 5, 6, 7 ]._intersect(8).should be_empty
        end
      end
    end

    context "when the other object is an array" do

      context "when the values intersect" do

        it "returns an intersected array" do
          [ 4, 5, 6 ]._intersect([ 6, 7 ]).should eq([ 6 ])
        end
      end

      context "when values do not intersect" do

        it "returns an empty array" do
          [ 4, 5 ]._intersect([ 6, 7 ]).should be_empty
        end
      end
    end

    context "when the other object is a hash" do

      pending "raises an error"
    end
  end
end
