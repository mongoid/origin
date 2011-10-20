require "spec_helper"

describe Origin::Selection::Between do

  let(:query) do
    Origin::Query.new
  end

  describe "#between" do

    context "when provided no criterion" do

      let(:selection) do
        query.between
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
        query.between(nil)
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

    context "when provided a single range" do

      let(:selection) do
        query.between(:field => 1..10)
      end

      it "adds the $gte and $lte selectors" do
        selection.selector.should eq({
          :field => { "$gte" => 1, "$lte" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple ranges" do

      context "when the ranges are on different fields" do

        let(:selection) do
          query.between(:field => 1..10, :key => 5..7)
        end

        it "adds the $gte and $lte selectors" do
          selection.selector.should eq({
            :field => { "$gte" => 1, "$lte" => 10 },
            :key => { "$gte" => 5, "$lte" => 7 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the ranges are on the same field" do

        let(:selection) do
          query.between(:field => 1..10, :field => 5..7)
        end

        it "adds overrides the first expression" do
          selection.selector.should eq({
            :field => { "$gte" => 5, "$lte" => 7 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end
end
