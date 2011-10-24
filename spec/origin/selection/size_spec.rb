require "spec_helper"

describe Origin::Selection::Size do

  let(:query) do
    Origin::Query.new
  end

  describe "#with_size" do

    context "when provided no criterion" do

      let(:selection) do
        query.with_size
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
        query.with_size(nil)
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
        query.with_size(:field => 10)
      end

      it "adds the $size selector" do
        selection.selector.should eq({
          :field => { "$size" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.with_size(:first => 10, :second => 15)
        end

        it "adds the $size selectors" do
          selection.selector.should eq({
            :first => { "$size" => 10 },
            :second => { "$size" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.with_size(:first => 10, :first => 15)
        end

        it "overwrites the first $size selector" do
          selection.selector.should eq({
            :first => { "$size" => 15 }
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
          query.with_size(:first => 10).with_size(:second => 15)
        end

        it "adds the $size selectors" do
          selection.selector.should eq({
            :first => { "$size" => 10 },
            :second => { "$size" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.with_size(:first => 10).with_size(:first => 15)
        end

        it "overwrites the first $size selector" do
          selection.selector.should eq({
            :first => { "$size" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#with_size" do

      let(:key) do
        :field.with_size
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selection::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $size" do
        key.operator.should eq("$size")
      end
    end
  end
end
