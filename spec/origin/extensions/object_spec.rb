require "spec_helper"

describe Object do

  describe "#__add__" do

    context "when the other object is a non-enumerable" do

      context "when the values are unique" do

        it "returns an array of both" do
          5.__add__(6).should eq([ 5, 6 ])
        end
      end

      context "when the values are not unique" do

        it "returns the original value" do
          5.__add__(5).should eq(5)
        end
      end
    end

    context "when the other object is an array" do

      context "when the values are unique" do

        it "returns an array of both" do
          5.__add__([ 6, 7 ]).should eq([ 5, 6, 7 ])
        end
      end

      context "when the values are not unique" do

        it "returns a unique array of both" do
          5.__add__([ 5, 6, 7 ]).should eq([ 5, 6, 7 ])
        end
      end
    end
  end

  describe "#__intersect__" do

    context "when the other object is a non-enumerable" do

      context "when the values intersect" do

        it "returns an intersected array" do
          5.__intersect__(5).should eq([ 5 ])
        end
      end

      context "when the values do not intersect" do

        it "returns an empty array" do
          5.__intersect__(6).should be_empty
        end
      end
    end

    context "when the other object is an array" do

      context "when the values intersect" do

        it "returns an intersected array" do
          5.__intersect__([ 5, 6 ]).should eq([ 5 ])
        end
      end

      context "when the values do not intersect" do

        it "returns an empty array " do
          5.__intersect__([ 6, 7 ]).should be_empty
        end
      end
    end
  end

  describe "#__union__" do

    context "when the other object is a non-enumerable" do

      context "when the values are the same" do

        it "returns an unioned array" do
          5.__union__(5).should eq([ 5 ])
        end
      end

      context "when the values are not the same" do

        it "returns an empty array" do
          5.__union__(6).should eq([ 5, 6 ])
        end
      end
    end

    context "when the other object is an array" do

      context "when the values are not the same" do

        it "returns an unioned array" do
          5.__union__([ 5, 6 ]).should eq([ 5, 6 ])
        end
      end
    end
  end
end
