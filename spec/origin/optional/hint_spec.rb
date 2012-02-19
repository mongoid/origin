require "spec_helper"

describe Origin::Optional::Hint do

  let(:query) do
    Origin::Query.new
  end

  describe "#hint" do

    context "when provided no options" do

      let(:selection) do
        query.hint
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
        query.hint(nil)
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
        query.hint(:first, :second)
      end

      it "adds the field options" do
        selection.options.should eq(
          { :hint => { :first => 1, :second => 1 }}
        )
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end
  end
end
