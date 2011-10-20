require "spec_helper"

describe Origin::Selection::And do

  let(:query) do
    Origin::Query.new
  end

  describe "#and" do

    context "when provided no criterion" do

      let(:selection) do
        query.and
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
        query.and(nil)
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
        query.and(:field => [ 1, 2 ])
      end

      it "adds the $and selector" do
        selection.selector.should eq({
          "$and" => [{ :field => [ 1, 2 ] }]
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.and({ :first => [ 1, 2 ] }, { :second => [ 3, 4 ] })
        end

        it "adds the $and selector" do
          selection.selector.should eq({
            "$and" => [
              { :first => [ 1, 2 ] },
              { :second => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.and({ :first => [ 1, 2 ] }, { :first => [ 3, 4 ] })
        end

        it "appends both $and expressions" do
          selection.selector.should eq({
            "$and" => [
              { :first => [ 1, 2 ] },
              { :first => [ 3, 4 ] }
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
          query.and(:first => [ 1, 2 ]).and(:second => [ 3, 4 ])
        end

        it "adds the $and selectors" do
          selection.selector.should eq({
            "$and" => [
              { :first => [ 1, 2 ] },
              { :second => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.and(:first => [ 1, 2 ]).and(:first => [ 3, 4 ])
        end

        it "appends both $and expressions" do
          selection.selector.should eq({
            "$and" => [
              { :first => [ 1, 2 ] },
              { :first => [ 3, 4 ] }
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
