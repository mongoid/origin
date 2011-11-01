require "spec_helper"

describe Origin::Optional::Read do

  let(:query) do
    Origin::Query.new
  end

  describe "#read" do

    context "when provided no options" do

      let(:selection) do
        query.read
      end

      it "does not add any options" do
        selection.options.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided nil" do

      let(:selection) do
        query.read(nil)
      end

      it "does not add any options" do
        selection.options.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided arguments" do

      let(:selection) do
        query.read(:secondary)
      end

      it "adds the field options" do
        selection.options.should eq({ :read => :secondary })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end
  end
end
