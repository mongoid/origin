require "spec_helper"

describe Origin::Selectable::WithinCircle do

  let(:query) do
    Origin::Query.new
  end

  describe "#within_circle" do

    context "when provided no criterion" do

      let(:selection) do
        query.within_circle
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
        query.within_circle(nil)
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
        query.within_circle(:location => [[ 1, 10 ], 25 ])
      end

      it "adds the $within expression" do
        selection.selector.should eq({
          :location => { "$within" => { "$center" => [[ 1, 10 ], 25 ] }}
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.within_circle(
            :location => [[ 1, 10 ], 25 ],
            :comments => [[ 1, 10 ], 25 ]
          )
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            :location => { "$within" => { "$center" => [[ 1, 10 ], 25 ] }},
            :comments => { "$within" => { "$center" => [[ 1, 10 ], 25 ] }}
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
            within_circle(:location => [[ 1, 10 ], 25 ]).
            within_circle(:comments => [[ 1, 10 ], 25 ])
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            :location => { "$within" => { "$center" => [[ 1, 10 ], 25 ] }},
            :comments => { "$within" => { "$center" => [[ 1, 10 ], 25 ] }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#within_circle" do

      let(:key) do
        :field.within_circle
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $within" do
        key.operator.should eq("$within")
      end

      it "sets the expanded operator as $center" do
        key.expanded.should eq("$center")
      end
    end
  end
end
