require "spec_helper"

describe Range do

  describe ".evolve" do

    context "when provided a range" do

      context "when the range is inclusive" do

        let(:range) do
          1..3
        end

        it "returns the inclusize range criterion" do
          described_class.evolve(range).should eq(
            { "$gte" => 1, "$lte" => 3 }
          )
        end
      end

      context "when the range is not inclusve" do

        let(:range) do
          1...3
        end

        it "returns the non inclusive range criterion" do
          described_class.evolve(range).should eq(
            { "$gte" => 1, "$lte" => 2 }
          )
        end
      end
    end

    context "when provided a string" do

      it "returns the string" do
        described_class.evolve("testing").should eq("testing")
      end
    end
  end
end
