require "spec_helper"

describe Origin::Selectable::Mod do

  let(:query) do
    Origin::Query.new
  end

  describe "#mod" do

    context "when provided no criterion" do

      let(:selection) do
        query.mod
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
        query.mod(nil)
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
        query.mod(value: [ 10, 1 ])
      end

      it "adds the $mod expression" do
        selection.selector.should eq({
          "value" =>  { "$mod" => [ 10, 1 ] }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.mod(
            value: [ 10, 1 ],
            comments: [ 10, 1 ]
          )
        end

        it "adds the $mod expression" do
          selection.selector.should eq({
            "value" =>  { "$mod" => [ 10, 1 ] },
            "comments" =>  { "$mod" => [ 10, 1 ] }
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
            mod(value: [ 10, 1 ]).
            mod(result: [ 10, 1 ])
        end

        it "adds the $mod expression" do
          selection.selector.should eq({
            "value" =>  { "$mod" => [ 10, 1 ] },
            "result" =>  { "$mod" => [ 10, 1 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#mod" do

      let(:key) do
        :field.mod
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $mod" do
        key.operator.should eq("$mod")
      end
    end
  end
end
