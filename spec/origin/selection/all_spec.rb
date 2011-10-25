require "spec_helper"

describe Origin::Selection::All do

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

      let(:selection) do
        query.all(:field => [ 1, 2 ])
      end

      it "adds the $all selector" do
        selection.selector.should eq({
          :field => { "$all" => [ 1, 2 ] }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.all(:first => [ 1, 2 ], :second => [ 3, 4 ])
        end

        it "adds the $all selectors" do
          selection.selector.should eq({
            :first => { "$all" => [ 1, 2 ] },
            :second => { "$all" => [ 3, 4 ] }
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
          query.all(:first => [ 1, 2 ]).all(:second => [ 3, 4 ])
        end

        it "adds the $all selectors" do
          selection.selector.should eq({
            :first => { "$all" => [ 1, 2 ] },
            :second => { "$all" => [ 3, 4 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.all(:first => [ 1, 2 ]).all(:first => [ 3, 4 ])
        end

        it "overwrites the first $all selector" do
          selection.selector.should eq({
            :first => { "$all" => [ 3, 4 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
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
        key.should be_a(Origin::Selection::Key)
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
