require "spec_helper"

describe Origin::Selectable::MaxDistance do

  let(:query) do
    Origin::Query.new
  end

  describe "#max_distance" do

    context "when provided no criterion" do

      let(:selection) do
        query.max_distance
      end

      it "does not add any criterion" do
        selection.selector.should eq({})
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
        query.max_distance(nil)
      end

      it "does not add any criterion" do
        selection.selector.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided a criterion" do

      context "when a $near criterion exists on the same field" do

        let(:selection) do
          query.near(location: [ 1, 1 ]).max_distance(location: 50)
        end

        it "adds the $maxDistance expression" do
          selection.selector.should eq({
            "location" =>  { "$near" => [ 1, 1 ], "$maxDistance" => 50 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end
end
