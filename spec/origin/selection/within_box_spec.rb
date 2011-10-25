require "spec_helper"

describe Origin::Selection::WithinBox do

  let(:query) do
    Origin::Query.new
  end

  describe "#within_box" do

    context "when provided no criterion" do

      let(:selection) do
        query.within_box
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
        query.within_box(nil)
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
        query.within_box(:location => [[ 1, 10 ], [ 10, 1 ]])
      end

      it "adds the $within expression" do
        selection.selector.should eq({
          :location => { "$within" => { "$box" => [[ 1, 10 ], [ 10, 1 ]] }}
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.within_box(
            :location => [[ 1, 10 ], [ 10, 1 ]],
            :comments => [[ 1, 10 ], [ 10, 1 ]]
          )
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            :location => { "$within" => { "$box" => [[ 1, 10 ], [ 10, 1 ]] }},
            :comments => { "$within" => { "$box" => [[ 1, 10 ], [ 10, 1 ]] }}
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
            within_box(:location => [[ 1, 10 ], [ 10, 1 ]]).
            within_box(:comments => [[ 1, 10 ], [ 10, 1 ]])
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            :location => { "$within" => { "$box" => [[ 1, 10 ], [ 10, 1 ]] }},
            :comments => { "$within" => { "$box" => [[ 1, 10 ], [ 10, 1 ]] }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#within_box" do

      let(:key) do
        :field.within_box
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selection::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $within" do
        key.operator.should eq("$within")
      end

      it "sets the expanded operator as $box" do
        key.expanded.should eq("$box")
      end
    end
  end
end
