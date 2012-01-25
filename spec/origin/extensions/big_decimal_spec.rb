require "spec_helper"

describe BigDecimal do

  describe ".evolve" do

    context "when provided a big decimal" do

      let(:big_decimal) do
        BigDecimal.new("123456.789")
      end

      it "returns the decimal as a string" do
        described_class.evolve(big_decimal).should eq(big_decimal.to_s)
      end
    end

    context "when provided a non big decimal" do

      it "returns the object as a string" do
        described_class.evolve("testing").should eq("testing")
      end
    end
  end
end
