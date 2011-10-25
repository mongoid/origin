require "spec_helper"

describe Origin::Selection::Type do

  let(:query) do
    Origin::Query.new
  end

  describe "#type" do

    context "when provided no criterion" do

      let(:selection) do
        query.type
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
        query.type(nil)
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
        query.type(:field => 10)
      end

      it "adds the $type selector" do
        selection.selector.should eq({
          :field => { "$type" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.type(:first => 10, :second => 15)
        end

        it "adds the $type selectors" do
          selection.selector.should eq({
            :first => { "$type" => 10 },
            :second => { "$type" => 15 }
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
          query.type(:first => 10).type(:second => 15)
        end

        it "adds the $type selectors" do
          selection.selector.should eq({
            :first => { "$type" => 10 },
            :second => { "$type" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.type(:first => 10).type(:first => 15)
        end

        it "overwrites the first $type selector" do
          selection.selector.should eq({
            :first => { "$type" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#type" do

      let(:key) do
        :field.type
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selection::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $type" do
        key.operator.should eq("$type")
      end
    end
  end
end
