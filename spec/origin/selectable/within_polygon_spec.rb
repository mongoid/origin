require "spec_helper"

describe Origin::Selectable::WithinPolygon do

  let(:query) do
    Origin::Query.new
  end

  describe "#within_polygon" do

    context "when provided no criterion" do

      let(:selection) do
        query.within_polygon
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
        query.within_polygon(nil)
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

      let(:polygon) do
        [[ 10, 20 ], [ 10, 40 ], [ 30, 40 ], [ 30, 20 ]]
      end

      let(:selection) do
        query.within_polygon(location: polygon)
      end

      it "adds the $within expression" do
        selection.selector.should eq({
          location: { "$within" => { "$polygon" => polygon }}
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:polygon_one) do
          [[ 10, 20 ], [ 10, 40 ], [ 30, 40 ], [ 30, 20 ]]
        end

        let(:polygon_two) do
          [[ 10, 25 ], [ 10, 45 ], [ 30, 45 ], [ 30, 25 ]]
        end

        let(:selection) do
          query.within_polygon(
            location: polygon_one,
            comments: polygon_two
          )
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            location: { "$within" => { "$polygon" => polygon_one }},
            comments: { "$within" => { "$polygon" => polygon_two }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining multiple criteria" do

      context "when the fields differ" do

        let(:polygon_one) do
          [[ 10, 20 ], [ 10, 40 ], [ 30, 40 ], [ 30, 20 ]]
        end

        let(:polygon_two) do
          [[ 10, 25 ], [ 10, 45 ], [ 30, 45 ], [ 30, 25 ]]
        end

        let(:selection) do
          query.
            within_polygon(location: polygon_one).
            within_polygon(comments: polygon_two)
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            location: { "$within" => { "$polygon" => polygon_one }},
            comments: { "$within" => { "$polygon" => polygon_two }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#within_polygon" do

      let(:key) do
        :field.within_polygon
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $within" do
        key.operator.should eq("$within")
      end

      it "sets the expanded operator as $polygon" do
        key.expanded.should eq("$polygon")
      end
    end
  end
end
