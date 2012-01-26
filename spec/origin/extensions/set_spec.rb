require "spec_helper"

describe Set do

  describe ".evolve" do

    context "when provided a set" do

      let(:set) do
        ::Set.new([ 1, 2, 3 ])
      end

      it "returns an array" do
        described_class.evolve(set).should eq([ 1, 2, 3 ])
      end
    end

    context "when provided an array" do

      it "returns an array" do
        described_class.evolve([ 1, 2, 3 ]).should eq([ 1, 2, 3 ])
      end
    end

    context "when provided another object" do

      it "returns the object" do
        described_class.evolve("testing").should eq("testing")
      end
    end

    context "when provided nil" do

      it "returns nil" do
        described_class.evolve(nil).should be_nil
      end
    end
  end
end
