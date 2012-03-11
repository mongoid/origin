require "spec_helper"

describe Origin::Optional::Limit do

  let(:query) do
    Origin::Query.new
  end

  describe "#limit" do

    context "when provided no options" do

      let(:selection) do
        query.limit
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
        query.limit(nil)
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

      context "when the argument is an integer" do

        let(:selection) do
          query.limit(10)
        end

        it "adds the field options" do
          selection.options.should eq({ limit: 10 })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the argument is a float" do

        let(:selection) do
          query.limit(10.25)
        end

        it "adds the field options as an integer" do
          selection.options.should eq({ limit: 10 })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the argument is a string" do

        let(:selection) do
          query.limit("10")
        end

        it "adds the field options as an integer" do
          selection.options.should eq({ limit: 10 })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end
end
