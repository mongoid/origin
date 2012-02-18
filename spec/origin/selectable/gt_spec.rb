require "spec_helper"

describe Origin::Selectable::Gt do

  let(:query) do
    Origin::Query.new
  end

  describe "#gt" do

    context "when provided no criterion" do

      let(:selection) do
        query.gt
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
        query.gt(nil)
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
        query.gt(field: 10)
      end

      it "adds the $gt selector" do
        selection.selector.should eq({
          field: { "$gt" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.gt(first: 10, second: 15)
        end

        it "adds the $gt selectors" do
          selection.selector.should eq({
            first: { "$gt" => 10 },
            second: { "$gt" => 15 }
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
          query.gt(first: 10).gt(second: 15)
        end

        it "adds the $gt selectors" do
          selection.selector.should eq({
            first: { "$gt" => 10 },
            second: { "$gt" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.gt(first: 10).gt(first: 15)
        end

        it "overwrites the first $gt selector" do
          selection.selector.should eq({
            first: { "$gt" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#gt" do

      let(:key) do
        :field.gt
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $gt" do
        key.operator.should eq("$gt")
      end
    end
  end
end
