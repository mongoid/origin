require "spec_helper"

describe Origin::Selection::Gte do

  let(:query) do
    Origin::Query.new
  end

  describe "#gte" do

    context "when provided no criterion" do

      let(:selection) do
        query.gte
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
        query.gte(nil)
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
        query.gte(:field => 10)
      end

      it "adds the $gte selector" do
        selection.selector.should eq({
          :field => { "$gte" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.gte(:first => 10, :second => 15)
        end

        it "adds the $gte selectors" do
          selection.selector.should eq({
            :first => { "$gte" => 10 },
            :second => { "$gte" => 15 }
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
          query.gte(:first => 10).gte(:second => 15)
        end

        it "adds the $gte selectors" do
          selection.selector.should eq({
            :first => { "$gte" => 10 },
            :second => { "$gte" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.gte(:first => 10).gte(:first => 15)
        end

        it "overwrites the first $gte selector" do
          selection.selector.should eq({
            :first => { "$gte" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#gte" do

      let(:key) do
        :field.gte
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selection::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $gte" do
        key.operator.should eq("$gte")
      end
    end
  end
end
