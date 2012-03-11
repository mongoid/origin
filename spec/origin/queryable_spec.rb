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

      context "when the options are the same" do

        it "returns true" do
          query.should eq(other)
        end
      end

      context "when the options are different" do

        before do
          other.options[:skip] = 20
        end

        it "returns false" do
          query.should_not eq(other)
        end
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

      it "initializes the options" do
        query.options.should eq({})
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
      { "name" => 1 }
    end

    let(:query) do
      described_class.new do |query|
        query.selector["field"] = "value"
        query.options["sort"] = { "field" => sort }
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

    it "retains the option values" do
      cloned.options.should eq({ "sort" => { "field" => sort }})
    end

    it "deep copies the selector" do
      cloned.selector.should_not equal(query.selector)
    end

    it "deep copies the options" do
      cloned.options.should_not equal(query.options)
    end

    it "deep copies n levels deep" do
      cloned.options["sort"]["field"].should_not equal(sort)
    end
  end
end
