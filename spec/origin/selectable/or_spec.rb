require "spec_helper"

describe Origin::Selectable::Or do

  let(:query) do
    Origin::Query.new
  end

  describe "#or" do

    context "when provided no criterion" do

      let(:selection) do
        query.or
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
        query.or(nil)
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

    context "when provided a single criterion" do

      let(:selection) do
        query.or(field: [ 1, 2 ])
      end

      it "adds the $or selector" do
        selection.selector.should eq({
          "$or" => [{ "field" => [ 1, 2 ] }]
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.or({ first: [ 1, 2 ] }, { second: [ 3, 4 ] })
        end

        it "adds the $or selector" do
          selection.selector.should eq({
            "$or" => [
              { "first" => [ 1, 2 ] },
              { "second" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.or({ first: [ 1, 2 ] }, { first: [ 3, 4 ] })
        end

        it "appends both $or expressions" do
          selection.selector.should eq({
            "$or" => [
              { "first" => [ 1, 2 ] },
              { "first" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.or(first: [ 1, 2 ]).or(second: [ 3, 4 ])
        end

        it "adds the $or selectors" do
          selection.selector.should eq({
            "$or" => [
              { "first" => [ 1, 2 ] },
              { "second" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.or(first: [ 1, 2 ]).or(first: [ 3, 4 ])
        end

        it "appends both $or expressions" do
          selection.selector.should eq({
            "$or" => [
              { "first" => [ 1, 2 ] },
              { "first" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end
end
