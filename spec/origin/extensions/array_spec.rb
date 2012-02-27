require "spec_helper"

describe Array do

  describe "#__add__" do

    context "when the other object is a non-enumerable" do

      context "when all values are unique" do

        it "returns an array of both" do
          [ 5, 6 ].__add__(7).should eq([ 5, 6, 7 ])
        end
      end

      context "when values are not unique" do

        it "returns a unique array of both" do
          [ 5, 6 ].__add__(6).should eq([ 5, 6 ])
        end
      end
    end

    context "when the other object is an array" do

      context "when all values are unique" do

        it "returns an array of both" do
          [ 4, 5 ].__add__([ 6, 7 ]).should eq([ 4, 5, 6, 7 ])
        end
      end

      context "when values are not unique" do

        it "returns a unique array of both" do
          [ 4, 5 ].__add__([ 5, 6, 7 ]).should eq([ 4, 5, 6, 7 ])
        end
      end
    end

    context "when the other object is a hash" do

      context "when all values are unique" do

        it "returns a hash of both" do
          [ 4, 5 ].__add__({ "$in" => [ 6, 7 ] }).should eq(
            { "$in" => [ 4, 5, 6, 7 ] }
          )
        end
      end

      context "when values are not unique" do

        it "returns a unique array of both" do
          [ 4, 5 ].__add__({ "$in" => [ 5, 6, 7 ] }).should eq(
            { "$in" => [ 4, 5, 6, 7 ] }
          )
        end
      end
    end
  end

  describe "#__intersect__" do

    context "when the other object is a non-enumerable" do

      context "when the values intersect" do

        it "returns an intersected array" do
          [ 5, 6, 7 ].__intersect__(6).should eq([ 6 ])
        end
      end

      context "when the values do not intersect" do

        it "returns an empty array" do
          [ 5, 6, 7 ].__intersect__(8).should be_empty
        end
      end
    end

    context "when the other object is an array" do

      context "when the values intersect" do

        it "returns an intersected array" do
          [ 4, 5, 6 ].__intersect__([ 6, 7 ]).should eq([ 6 ])
        end
      end

      context "when values do not intersect" do

        it "returns an empty array" do
          [ 4, 5 ].__intersect__([ 6, 7 ]).should be_empty
        end
      end
    end

    context "when the other object is a hash" do

      context "when the values intersect" do

        it "returns a hash of both" do
          [ 4, 5 ].__intersect__({ "$in" => [ 5, 6 ] }).should eq(
            { "$in" => [ 5 ] }
          )
        end
      end

      context "when values do not intersect" do

        it "returns an empty array" do
          [ 4, 5 ].__intersect__({ "$in" => [ 6, 7 ] }).should eq(
            { "$in" => [] }
          )
        end
      end
    end
  end

  describe "__deep_copy__" do

    let(:inner) do
      [ 3, 4 ]
    end

    let(:array) do
      [ 1, 2, inner ]
    end

    let(:copy) do
      array.__deep_copy__
    end

    it "returns an equal array" do
      copy.should eq(array)
    end

    it "returns a copy" do
      copy.should_not equal(array)
    end

    it "deep copies the elements" do
      copy[2].should_not equal(inner)
    end
  end

  describe "#__union__" do

    context "when the other object is a non-enumerable" do

      it "returns an unioned array" do
        [ 5, 6, 7 ].__union__(6).should eq([ 5, 6, 7 ])
      end
    end

    context "when the other object is an array" do

      it "returns an unioned array" do
        [ 4, 5, 6 ].__union__([ 6, 7 ]).should eq([ 4, 5, 6, 7 ])
      end
    end

    context "when the other object is a hash" do

      it "returns a hash with a unioned array" do
        [ 4, 5 ].__union__({ "$in" => [ 5, 6 ] }).should eq(
          { "$in" => [ 4, 5, 6 ] }
        )
      end
    end
  end

  describe "#as_sorting_options" do

    context "when the first element is an array" do

      context "when the array is multi-dimensional" do

        context "when the arrays have integer values" do

          let(:selection) do
            [[ :field_one, 1 ],[ :field_two, -1 ]]
          end

          it "returns the sorting criteria" do
            selection.as_sorting_options.should eq(
              { field_one: 1, field_two: -1 }
            )
          end
        end
      end
    end
  end
end
