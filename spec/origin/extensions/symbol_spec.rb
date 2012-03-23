require "spec_helper"

describe Symbol do

  describe ".add_key" do

    before do
      described_class.add_key(:fubar, :union, "$fu", "$bar") do |value|
        value.to_s
      end
    end

    let(:fubar) do
      :testing.fubar
    end

    it "adds the method to symbol" do
      fubar.should be_a(Origin::Key)
    end

    it "sets the key name" do
      fubar.name.should eq(:testing)
    end

    it "sets the key strategy" do
      fubar.strategy.should eq(:__union__)
    end

    it "sets the key operator" do
      fubar.operator.should eq("$fu")
    end

    it "sets the additional key operator" do
      fubar.expanded.should eq("$bar")
    end

    it "sets the transform block" do
      fubar.block.should be
    end
  end

  describe ".evolve" do

    context "when provided nil" do

      it "returns nil" do
        described_class.evolve(nil).should be_nil
      end
    end

    context "when provided a string" do

      it "returns the string as a symbol" do
        described_class.evolve("test").should eq(:test)
      end
    end
  end

  describe "#specify" do

    let(:specified) do
      :field.specify(10)
    end

    it "returns the string with the value" do
      specified.should eq({ field: 10 })
    end
  end

  describe "#to_direction" do

    context "when ascending" do

      it "returns 1" do
        :ascending.to_direction.should eq(1)
      end
    end

    context "when asc" do

      it "returns 1" do
        :asc.to_direction.should eq(1)
      end
    end

    context "when ASCENDING" do

      it "returns 1" do
        :ASCENDING.to_direction.should eq(1)
      end
    end

    context "when ASC" do

      it "returns 1" do
        :ASC.to_direction.should eq(1)
      end
    end

    context "when descending" do

      it "returns -1" do
        :descending.to_direction.should eq(-1)
      end
    end

    context "when desc" do

      it "returns -1" do
        :desc.to_direction.should eq(-1)
      end
    end

    context "when DESCENDING" do

      it "returns -1" do
        :DESCENDING.to_direction.should eq(-1)
      end
    end

    context "when DESC" do

      it "returns -1" do
        :DESC.to_direction.should eq(-1)
      end
    end
  end
end
