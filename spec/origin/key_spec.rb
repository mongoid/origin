require "spec_helper"

describe Origin::Key do

  describe "#initialize" do

    let(:key) do
      described_class.new("field", :__union__, "$all")
    end

    it "sets the name" do
      key.name.should eq("field")
    end

    it "sets the operator" do
      key.operator.should eq("$all")
    end

    it "sets the strategy" do
      key.strategy.should eq(:__union__)
    end
  end

  describe "#specify" do

    let(:key) do
      described_class.new("field", :__union__, "$all")
    end

    let(:specified) do
      key.specify([ 1, 2 ])
    end

    it "returns the name plus operator and value" do
      specified.should eq({ "field" => { "$all" => [ 1, 2 ] }})
    end
  end
end
