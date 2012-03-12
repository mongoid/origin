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

    context "when provided an array of big decimals" do

      let(:bd_one) do
        BigDecimal.new("123456.789")
      end

      let(:bd_two) do
        BigDecimal.new("123333.789")
      end

      let(:evolved) do
        described_class.evolve([ bd_one, bd_two ])
      end

      it "returns the array as strings" do
        evolved.should eq([ bd_one.to_s, bd_two.to_s ])
      end
    end

    context "when provided nil" do

      it "returns nil" do
        described_class.evolve(nil).should be_nil
      end
    end
  end
end
