require "spec_helper"

describe Origin::Selectable::Lte do

  let(:query) do
    Origin::Query.new
  end

  describe "#lte" do

    context "when provided no criterion" do

      let(:selection) do
        query.lte
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
        query.lte(nil)
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
        query.lte(field: 10)
      end

      it "adds the $lte selector" do
        selection.selector.should eq({
          "field" =>  { "$lte" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.lte(first: 10, second: 15)
        end

        it "adds the $lte selectors" do
          selection.selector.should eq({
            "first" =>  { "$lte" => 10 },
            "second" =>  { "$lte" => 15 }
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
          query.lte(first: 10).lte(second: 15)
        end

        it "adds the $lte selectors" do
          selection.selector.should eq({
            "first" =>  { "$lte" => 10 },
            "second" =>  { "$lte" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.lte(first: 10).lte(first: 15)
        end

        it "overwrites the first $lte selector" do
          selection.selector.should eq({
            "first" =>  { "$lte" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#lte" do

      let(:key) do
        :field.lte
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $lte" do
        key.operator.should eq("$lte")
      end
    end
  end
end
