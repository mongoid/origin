require "spec_helper"

describe Origin::Selectable::All do

  let(:query) do
    Origin::Query.new
  end

  describe "#all" do

    context "when provided no criterion" do

      let(:selection) do
        query.all
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
        query.all(nil)
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
          query.all(field: [ 1, 2 ])
        end

        it "adds the $all selector" do
          selection.selector.should eq({
            "field" => { "$all" => [ 1, 2 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when providing a range" do

        let(:selection) do
          query.all(field: 1..3)
        end

        it "adds the $all selector with converted range" do
          selection.selector.should eq({
            "field" => { "$all" => [ 1, 2, 3 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when providing a single value" do

        let(:selection) do
          query.all(field: 1)
        end

        it "adds the $all selector with wrapped value" do
          selection.selector.should eq({
            "field" => { "$all" => [ 1 ] }
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
          query.all(first: [ 1, 2 ], second: [ 3, 4 ])
        end

        it "adds the $all selectors" do
          selection.selector.should eq({
            "first" => { "$all" => [ 1, 2 ] },
            "second" => { "$all" => [ 3, 4 ] }
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
          query.all(first: [ 1, 2 ]).all(second: [ 3, 4 ])
        end

        it "adds the $all selectors" do
          selection.selector.should eq({
            "first" => { "$all" => [ 1, 2 ] },
            "second" => { "$all" => [ 3, 4 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        context "when the strategy is the default (union)" do

          let(:selection) do
            query.all(first: [ 1, 2 ]).all(first: [ 3, 4 ])
          end

          it "overwrites the first $all selector" do
            selection.selector.should eq({
              "first" => { "$all" => [ 1, 2, 3, 4 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the strategy is intersect" do

          let(:selection) do
            query.all(first: [ 1, 2 ]).intersect.all(first: [ 2, 3 ])
          end

          it "intersects the $all selectors" do
            selection.selector.should eq({
              "first" => { "$all" => [ 2 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the strategy is override" do

          let(:selection) do
            query.all(first: [ 1, 2 ]).override.all(first: [ 3, 4 ])
          end

          it "overwrites the first $all selector" do
            selection.selector.should eq({
              "first" => { "$all" => [ 3, 4 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the strategy is union" do

          let(:selection) do
            query.all(first: [ 1, 2 ]).union.all(first: [ 3, 4 ])
          end

          it "unions the $all selectors" do
            selection.selector.should eq({
              "first" => { "$all" => [ 1, 2, 3, 4 ] }
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

    describe "#all" do

      let(:key) do
        :field.all
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $all" do
        key.operator.should eq("$all")
      end
    end
  end
end
