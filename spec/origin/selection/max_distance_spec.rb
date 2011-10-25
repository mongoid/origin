require "spec_helper"

describe Origin::Selection::MaxDistance do

  let(:query) do
    Origin::Query.new
  end

  describe "#max_distance" do

    context "when provided no criterion" do

      let(:selection) do
        query.max_distance
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
        query.max_distance(nil)
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

      context "when a $near criterion exists on the same field" do

        let(:selection) do
          query.near(:location => [ 1, 1 ]).max_distance(:location => 50)
        end

        it "adds the $maxDistance expression" do
          selection.selector.should eq({
            :location => { "$near" => [ 1, 1 ], "$maxDistance" => 50 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when a $near criterion does not exist on the same field" do

        let(:selection) do
          query.max_distance(:location => 50)
        end

        it "does not add the $maxDistance expression" do
          selection.selector.should eq({})
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining multiple criteria" do

      context "when the fields are the same" do

        let(:selection) do
          query.
            near(:location => [ 1, 1 ]).
            max_distance(:location => 50).
            max_distance(:location => 10)
        end

        it "overrides the $maxDistance expression" do
          selection.selector.should eq({
            :location => { "$near" => [ 1, 1 ], "$maxDistance" => 10 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#max_distance" do

      let(:key) do
        :field.max_distance
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selection::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $maxDistance" do
        key.operator.should eq("$maxDistance")
      end
    end
  end
end
