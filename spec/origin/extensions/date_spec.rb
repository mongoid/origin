require "spec_helper"

describe Date do

  describe ".evolve" do

    context "when provided a date" do

      let(:date) do
        Date.new(2010, 1, 1)
      end

      let(:evolved) do
        described_class.evolve(date)
      end

      let(:expected) do
        Time.utc(2010, 1, 1, 0, 0, 0)
      end

      it "returns the time" do
        evolved.should eq(expected)
      end
    end

    context "when provided an array" do

      context "when the array is composed of dates" do

        let(:date) do
          Date.new(2010, 1, 1)
        end

        let(:evolved) do
          described_class.evolve([ date ])
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
          described_class.evolve([ date.to_s ])
        end

        it "returns the strings as a times" do
          evolved.should eq([ Time.new(2010, 1, 1, 0, 0, 0, 0).utc ])
        end
      end

      context "when the array is composed of integers" do

        let(:integer) do
          1262300400
        end

        let(:evolved) do
          described_class.evolve([ integer ])
        end

        let(:expected) do
          Time.at(integer)
        end

        it "returns the integers as times" do
          evolved.should eq([ Time.new(2010, 1, 1, 0, 0, 0, 0).utc ])
        end
      end

      context "when the array is composed of floats" do

        let(:float) do
          1262300400.413
        end

        let(:evolved) do
          described_class.evolve([ float ])
        end

        let(:expected) do
          Time.at(float)
        end

        it "returns the floats as times" do
          evolved.should eq([ Time.new(2010, 1, 1, 0, 0, 0, 0).utc ])
        end
      end
    end

    context "when provided a range" do

      context "when the range are dates" do

        let(:min) do
          Date.new(2010, 1, 1)
        end

        let(:max) do
          Date.new(2010, 1, 3)
        end

        let(:evolved) do
          described_class.evolve(min..max)
        end

        let(:expected_min) do
          Time.utc(2010, 1, 1, 0, 0, 0, 0)
        end

        let(:expected_max) do
          Time.utc(2010, 1, 3, 0, 0, 0, 0)
        end

        it "returns a selection of times" do
          evolved.should eq(
            { "$gte" => expected_min, "$lte" => expected_max }
          )
        end
      end

      context "when the range are strings" do

        let(:min) do
          Date.new(2010, 1, 1)
        end

        let(:max) do
          Date.new(2010, 1, 3)
        end

        let(:evolved) do
          described_class.evolve(min.to_s..max.to_s)
        end

        let(:expected_min) do
          Time.utc(2010, 1, 1, 0, 0, 0, 0)
        end

        let(:expected_max) do
          Time.utc(2010, 1, 3, 0, 0, 0, 0)
        end

        it "returns a selection of times" do
          evolved.should eq(
            { "$gte" => expected_min, "$lte" => expected_max }
          )
        end
      end

      context "when the range is floats" do

        let(:min) do
          1262300400.413
        end

        let(:max) do
          1262476800.7651
        end

        let(:evolved) do
          described_class.evolve(min..max)
        end

        let(:expected_min) do
          Time.utc(2010, 1, 1, 0, 0, 0, 0)
        end

        let(:expected_max) do
          Time.utc(2010, 1, 3, 0, 0, 0, 0)
        end

        it "returns a selection of times" do
          evolved.should eq(
            { "$gte" => expected_min, "$lte" => expected_max }
          )
        end
      end

      context "when the range is integers" do

        let(:min) do
          1262300400
        end

        let(:max) do
          1262476800
        end

        let(:evolved) do
          described_class.evolve(min..max)
        end

        let(:expected_min) do
          Time.utc(2010, 1, 1, 0, 0, 0, 0)
        end

        let(:expected_max) do
          Time.utc(2010, 1, 3, 0, 0, 0, 0)
        end

        it "returns a selection of times" do
          evolved.should eq(
            { "$gte" => expected_min, "$lte" => expected_max }
          )
        end
      end

      context "when the range is not convertable" do

        let(:evolved) do
          described_class.evolve("132".."1211")
        end

        pending "raises an error" do
        end
      end
    end

    context "when provided a string" do

      let(:date) do
        Date.parse("1st Jan 2010")
      end

      let(:evolved) do
        described_class.evolve(date.to_s)
      end

      let(:expected) do
        Time.utc(2010, 1, 1, 0, 0, 0, 0)
      end

      it "returns the string as a time" do
        evolved.should eq(expected)
      end
    end

    context "when provided a float" do

      let(:float) do
        1262300400.413
      end

      let(:evolved) do
        described_class.evolve(float)
      end

      let(:expected) do
        Time.utc(2010, 1, 1, 0, 0, 0, 0)
      end

      it "returns the float as a time" do
        evolved.should eq(expected)
      end
    end

    context "when provided an integer" do

      let(:integer) do
        1262300400
      end

      let(:evolved) do
        described_class.evolve(integer)
      end

      let(:expected) do
        Time.utc(2010, 1, 1, 0, 0, 0, 0)
      end

      it "returns the integer as a time" do
        evolved.should eq(expected)
      end
    end

    context "when provided nil" do

      it "returns nil" do
        described_class.evolve(nil).should be_nil
      end
    end

    context "when provided a non-convertable object" do

      pending "raises an error" do
      end
    end
  end
end
