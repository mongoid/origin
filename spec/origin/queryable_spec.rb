require "spec_helper"

describe Origin::Query do

  describe "#==" do

    let(:query) do
      described_class.new
    end

    context "when the objects have the same selector" do

      let(:other) do
        described_class.new
      end

      it "returns true" do
        query.should eq(other)
      end
    end

    context "when the objects have different selectors" do

      let(:other) do
        described_class.new do |query|
          query.selector["field"] = "value"
        end
      end

      it "returns false" do
        query.should_not eq(other)
      end
    end

    context "when the objects are different types" do

      let(:other) do
        "Query"
      end

      it "returns false" do
        query.should_not eq(other)
      end
    end
  end

  describe "#initialize" do

    context "when passed no arguments" do

      let(:query) do
        described_class.new
      end

      it "intializes the selector" do
        query.selector.should eq({})
      end
    end

    context "when passed a block" do

      let(:query) do
        described_class.new do |query|
          query.selector["field"] = "value"
        end
      end

      it "yields to the block" do
        query.selector.should eq({ "field" => "value" })
      end
    end
  end

  describe "#initialize_copy" do

    let(:sort) do
      [[ :name, :asc ]]
    end

    let(:query) do
      described_class.new do |query|
        query.selector["field"] = "value"
      end
    end

    let!(:cloned) do
      query.clone
    end

    it "returns a query" do
      cloned.should be_a(Origin::Query)
    end

    it "returns a new instance" do
      cloned.should_not equal(query)
    end

    it "retains the selector values" do
      cloned.selector.should eq({ "field" => "value" })
    end

    it "deep copies the selector" do
      cloned.selector.should_not equal(query.selector)
    end
  end
end
