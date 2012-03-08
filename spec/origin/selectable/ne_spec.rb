require "spec_helper"

describe Origin::Selectable::Ne do

  let(:query) do
    Origin::Query.new
  end

  describe "#ne" do

    context "when provided no criterion" do

      let(:selection) do
        query.ne
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
        query.ne(nil)
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

      let(:selection) do
        query.ne(value: 10)
      end

      it "adds the $ne expression" do
        selection.selector.should eq({
          "value" =>  { "$ne" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.ne(
            value: 10,
            comments: 10
          )
        end

        it "adds the $ne expression" do
          selection.selector.should eq({
            "value" =>  { "$ne" => 10 },
            "comments" =>  { "$ne" => 10 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.
            ne(value: 10).
            ne(result: 10)
        end

        it "adds the $ne expression" do
          selection.selector.should eq({
            "value" =>  { "$ne" => 10 },
            "result" =>  { "$ne" => 10 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#ne" do

      let(:key) do
        :field.ne
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $ne" do
        key.operator.should eq("$ne")
      end
    end
  end
end
