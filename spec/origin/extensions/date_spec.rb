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

      it "returns the time" do
        evolved.should eq(date.to_time)
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

        it "returns a selection of times" do
          evolved.should eq(
            { "$gte" => min.to_time, "$lte" => max.to_time }
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

        it "returns a selection of times" do
          evolved.should eq(
            { "$gte" => min.to_time, "$lte" => max.to_time }
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

      it "returns the string as a time" do
      end
    end

    context "when provided nil" do

    end

    context "when provided a non-convertable object" do

    end
  end
end
