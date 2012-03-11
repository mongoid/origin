require "spec_helper"

describe Origin::Optional::Ascending do

  let(:query) do
    Origin::Query.new
  end

  [ :asc, :ascending ].each do |method|

    describe "##{method}" do

      context "when provided symbols" do

        let(:selection) do
          query.send(method, :field_one, :field_two)
        end

        it "adds the sorting criteria" do
          selection.options.should eq(
            { sort: { "field_one" => 1, "field_two" => 1 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when provided an array of symbols" do

        let(:selection) do
          query.send(method, [ :field_one, :field_two ])
        end

        it "adds the sorting criteria" do
          selection.options.should eq(
            { sort: { "field_one" => 1, "field_two" => 1 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when provided strings" do

        let(:selection) do
          query.send(method, "field_one", "field_two")
        end

        it "adds the sorting criteria" do
          selection.options.should eq(
            { sort: { "field_one" => 1, "field_two" => 1 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when provided an array of strings" do

        let(:selection) do
          query.send(method, [ "field_one", "field_two" ])
        end

        it "adds the sorting criteria" do
          selection.options.should eq(
            { sort: { "field_one" => 1, "field_two" => 1 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when provided no options" do

        let(:selection) do
          query.send(method)
        end

        it "does not add any sorting criteria" do
          selection.options.should be_empty
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
          query.send(method, nil)
        end

        it "does not add any sorting criteria" do
          selection.options.should be_empty
        end

        it "returns the query" do
          selection.should eq(query)
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end
end
