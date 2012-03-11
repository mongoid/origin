require "spec_helper"

describe Origin::Optional::Skip do

  let(:query) do
    Origin::Query.new
  end

  describe "#skip" do

    context "when provided no options" do

      let(:selection) do
        query.skip
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
        query.skip(nil)
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

      context "when provided an integer" do

        let(:selection) do
          query.skip(10)
        end

        it "adds the field options" do
          selection.options.should eq({ "skip" => 10 })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when provided a float" do

        let(:selection) do
          query.skip(10.25)
        end

        it "adds the field options converted to an integer" do
          selection.options.should eq({ "skip" => 10 })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when provided a non number" do

        let(:selection) do
          query.skip("10")
        end

        it "adds the field options converted to an integer" do
          selection.options.should eq({ "skip" => 10 })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end
end
