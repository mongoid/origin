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

  describe "#__array__" do

    it "returns self" do
      [ 1, 2, 3 ].__array__.should eq([ 1, 2, 3 ])
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

  describe "#__evolve_date__" do

    context "when the array is composed of dates" do

      let(:date) do
        Date.new(2010, 1, 1)
      end

      let(:evolved) do
        [ date ].__evolve_date__
      end

      let(:expected) do
        Time.utc(2010, 1, 1, 0, 0, 0, 0)
      end

      it "returns the array with evolved times" do
        evolved.should eq([ expected ])
      end
    end

    context "when the array is composed of strings" do

      let(:date) do
        Date.parse("1st Jan 2010")
      end

      let(:evolved) do
        [ date.to_s ].__evolve_date__
      end

      it "returns the strings as a times" do
        evolved.should eq([ Time.new(2010, 1, 1, 0, 0, 0, 0).utc ])
      end
    end

    context "when the array is composed of integers" do

      let(:time) do
        Time.utc(2010, 1, 1, 0, 0, 0, 0)
      end

      let(:integer) do
        time.to_i
      end

      let(:evolved) do
        [ integer ].__evolve_date__
      end

      let(:expected) do
        Time.at(integer)
      end

      it "returns the integers as times" do
        evolved.should eq([ time ])
      end
    end

    context "when the array is composed of floats" do

      let(:time) do
        Time.utc(2010, 1, 1, 0, 0, 0, 0)
      end

      let(:float) do
        time.to_f
      end

      let(:evolved) do
        [ float ].__evolve_date__
      end

      let(:expected) do
        Time.at(float)
      end

      it "returns the floats as times" do
        evolved.should eq([ time ])
      end
    end
  end

  describe "__evolve_time__" do

    context "when the array is composed of times" do

      let(:date) do
        Time.new(2010, 1, 1, 12, 0, 0)
      end

      let(:evolved) do
        [ date ].__evolve_time__
      end

      let(:expected) do
        Time.new(2010, 1, 1, 12, 0, 0).utc
      end

      it "returns the array with evolved times" do
        evolved.should eq([ expected ])
      end

      it "returns utc times" do
        evolved.first.utc_offset.should eq(0)
      end
    end

    context "when the array is composed of strings" do

      let(:date) do
        Time.parse("1st Jan 2010 12:00:00+01:00")
      end

      let(:evolved) do
        [ date.to_s ].__evolve_time__
      end

      it "returns the strings as a times" do
        evolved.should eq([ date.to_time ])
      end

      it "returns the times in utc" do
        evolved.first.utc_offset.should eq(0)
      end
    end

    context "when the array is composed of integers" do

      let(:integer) do
        1331890719
      end

      let(:evolved) do
        [ integer ].__evolve_time__
      end

      let(:expected) do
        Time.at(integer).utc
      end

      it "returns the integers as times" do
        evolved.should eq([ expected ])
      end

      it "returns the times in utc" do
        evolved.first.utc_offset.should eq(0)
      end
    end

    context "when the array is composed of floats" do

      let(:float) do
        1331890719.413
      end

      let(:evolved) do
        [ float ].__evolve_time__
      end

      let(:expected) do
        Time.at(float).utc
      end

      it "returns the floats as times" do
        evolved.should eq([ expected ])
      end

      it "returns the times in utc" do
        evolved.first.utc_offset.should eq(0)
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

  describe "#__sort_option__" do

    context "when the array is one dimensional" do

      it "returns a hash of sort options" do
        [ :field, 1 ].__sort_option__.should eq({ field: 1 })
      end
    end

    context "when the array is multi dimensional" do

      it "returns a hash of sort options" do
        [[ :field, 1 ]].__sort_option__.should eq({ field: 1 })
      end
    end
  end

  describe "#__sort_pair__" do

    context "when the direction is a symbol" do

      it "converts the symbol to an integer" do
        [ :field, :asc ].__sort_pair__.should eq({ field: 1 })
      end
    end

    context "when the direction is an integer" do

      it "returns the array as a hash" do
        [ :field, 1 ].__sort_pair__.should eq({ field: 1 })
      end
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

  describe "#__sort_option__" do

    context "when the array is multi-dimensional" do

      context "when the arrays have integer values" do

        let(:selection) do
          [[ :field_one, 1 ],[ :field_two, -1 ]]
        end

        it "adds the sorting criteria" do
          selection.__sort_option__.should eq(
            { field_one: 1, field_two: -1 }
          )
        end
      end

      context "when the arrays have symbol values" do

        let(:selection) do
          [[ :field_one, :asc ],[ :field_two, :desc ]]
        end

        it "adds the sorting criteria" do
          selection.__sort_option__.should eq(
            { field_one: 1, field_two: -1 }
          )
        end
      end

      context "when the arrays have string values" do

        let(:selection) do
          [[ :field_one, "asc" ],[ :field_two, "desc" ]]
        end

        it "adds the sorting criteria" do
          selection.__sort_option__.should eq(
            { field_one: 1, field_two: -1 }
          )
        end
      end
    end

    context "when the array is one-dimensional" do

      context "when the arrays have integer values" do

        let(:selection) do
          [ :field_one, 1 ]
        end

        it "adds the sorting criteria" do
          selection.__sort_option__.should eq(
            { field_one: 1 }
          )
        end
      end
    end

    context "when the array is selectable keys" do

      let(:selection) do
        [ :field_one.asc, :field_two.desc ]
      end

      it "adds the sorting criteria" do
        selection.__sort_option__.should eq(
          { field_one: 1, field_two: -1 }
        )
      end
    end
  end
end
