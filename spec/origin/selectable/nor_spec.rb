require "spec_helper"

describe Origin::Selectable::Nor do

  let(:query) do
    Origin::Query.new
  end

  describe "#nor" do

    context "when provided no criterion" do

      let(:selection) do
        query.nor
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
        query.nor(nil)
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
        query.nor(field: [ 1, 2 ])
      end

      it "adds the $nor selector" do
        selection.selector.should eq({
          "$nor" => [{ field: [ 1, 2 ] }]
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are fnor different fields" do

        let(:selection) do
          query.nor({ first: [ 1, 2 ] }, { second: [ 3, 4 ] })
        end

        it "adds the $nor selector" do
          selection.selector.should eq({
            "$nor" => [
              { first: [ 1, 2 ] },
              { second: [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.nor({ first: [ 1, 2 ] }, { first: [ 3, 4 ] })
        end

        it "appends both $nor expressions" do
          selection.selector.should eq({
            "$nor" => [
              { first: [ 1, 2 ] },
              { first: [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are fnor different fields" do

        let(:selection) do
          query.nor(first: [ 1, 2 ]).nor(second: [ 3, 4 ])
        end

        it "adds the $nor selectors" do
          selection.selector.should eq({
            "$nor" => [
              { first: [ 1, 2 ] },
              { second: [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.nor(first: [ 1, 2 ]).nor(first: [ 3, 4 ])
        end

        it "appends both $nor expressions" do
          selection.selector.should eq({
            "$nor" => [
              { first: [ 1, 2 ] },
              { first: [ 3, 4 ] }
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
