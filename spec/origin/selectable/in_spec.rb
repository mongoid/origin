require "spec_helper"

describe Origin::Selectable::In do

  let(:query) do
    Origin::Query.new
  end

  describe "#in" do

    context "when provided no criterion" do

      let(:selection) do
        query.in
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
        query.in(nil)
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

      context "when providing an array" do

        let(:selection) do
          query.in(field: [ 1, 2 ])
        end

        it "adds the $in selector" do
          selection.selector.should eq({
            field: { "$in" => [ 1, 2 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when providing a range" do

        let(:selection) do
          query.in(field: 1..3)
        end

        it "adds the $in selector with converted range" do
          selection.selector.should eq({
            field: { "$in" => [ 1, 2, 3 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when providing a single value" do

        let(:selection) do
          query.in(field: 1)
        end

        it "adds the $in selector with wrapped value" do
          selection.selector.should eq({
            field: { "$in" => [ 1 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.in(first: [ 1, 2 ], second: 3..4)
        end

        it "adds the $in selectors" do
          selection.selector.should eq({
            first: { "$in" => [ 1, 2 ] },
            second: { "$in" => [ 3, 4 ] }
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
          query.in(first: [ 1, 2 ]).in(second: [ 3, 4 ])
        end

        it "adds the $in selectors" do
          selection.selector.should eq({
            first: { "$in" => [ 1, 2 ] },
            second: { "$in" => [ 3, 4 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        context "when the stretegy is the default (intersection)" do

          let(:selection) do
            query.in(first: [ 1, 2 ]).in(first: [ 2, 3 ])
          end

          it "intersects the $in selectors" do
            selection.selector.should eq({
              first: { "$in" => [ 2 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is intersect" do

          let(:selection) do
            query.in(first: [ 1, 2 ]).intersect.in(first: [ 2, 3 ])
          end

          it "intersects the $in selectors" do
            selection.selector.should eq({
              first: { "$in" => [ 2 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is override" do

          let(:selection) do
            query.in(first: [ 1, 2 ]).override.in(first: [ 3, 4 ])
          end

          it "overwrites the first $in selector" do
            selection.selector.should eq({
              first: { "$in" => [ 3, 4 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is union" do

          let(:selection) do
            query.in(first: [ 1, 2 ]).union.in(first: [ 3, 4 ])
          end

          it "unions the $in selectors" do
            selection.selector.should eq({
              first: { "$in" => [ 1, 2, 3, 4 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end
    end
  end

  describe Symbol do

    describe "#in" do

      let(:key) do
        :field.in
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $in" do
        key.operator.should eq("$in")
      end
    end
  end
end
