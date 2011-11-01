require "spec_helper"

describe Origin::Optional::Transformer do

  let(:query) do
    Origin::Query.new
  end

  describe "#transformer" do

    context "when provided no options" do

      let(:selection) do
        query.transformer
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
        query.transformer(nil)
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

      let(:block) do
        lambda { |doc| doc }
      end

      let(:selection) do
        query.transformer(block)
      end

      it "adds the field options" do
        selection.options.should eq({ :transformer => block })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end
  end
end
