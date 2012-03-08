require "spec_helper"

describe Origin::Selectable::Lt do

  let(:query) do
    Origin::Query.new
  end

  describe "#lt" do

    context "when provided no criterion" do

      let(:selection) do
        query.lt
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
        query.lt(nil)
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
        query.lt(field: 10)
      end

      it "adds the $lt selector" do
        selection.selector.should eq({
          "field" =>  { "$lt" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.lt(first: 10, second: 15)
        end

        it "adds the $lt selectors" do
          selection.selector.should eq({
            "first" =>  { "$lt" => 10 },
            "second" =>  { "$lt" => 15 }
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
          query.lt(first: 10).lt(second: 15)
        end

        it "adds the $lt selectors" do
          selection.selector.should eq({
            "first" =>  { "$lt" => 10 },
            "second" =>  { "$lt" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.lt(first: 10).lt(first: 15)
        end

        it "overwrites the first $lt selector" do
          selection.selector.should eq({
            "first" =>  { "$lt" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#lt" do

      let(:key) do
        :field.lt
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $lt" do
        key.operator.should eq("$lt")
      end
    end
  end
end
