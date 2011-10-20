require "spec_helper"

describe Origin::Selection::ElemMatch do

  let(:query) do
    Origin::Query.new
  end

  describe "#elem_match" do

    context "when provided no criterion" do

      let(:selection) do
        query.elem_match
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
        query.elem_match(nil)
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
        query.elem_match(:users => { :name => "value" })
      end

      it "adds the $elemMatch expression" do
        selection.selector.should eq({
          :users => { "$elemMatch" => { :name => "value" }}
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.elem_match(
            :users => { :name => "value" },
            :comments => { :text => "value" }
          )
        end

        it "adds the $elemMatch expression" do
          selection.selector.should eq({
            :users => { "$elemMatch" => { :name => "value" }},
            :comments => { "$elemMatch" => { :text => "value" }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the fields are the same" do

        let(:selection) do
          query.elem_match(
            :users => { :name => "value" },
            :users => { :state => "new" }
          )
        end

        it "overrides the $elemMatch expression" do
          selection.selector.should eq({
            :users => { "$elemMatch" => { :state => "new" }}
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
            elem_match(:users => { :name => "value" }).
            elem_match(:comments => { :text => "value" })
        end

        it "adds the $elemMatch expression" do
          selection.selector.should eq({
            :users => { "$elemMatch" => { :name => "value" }},
            :comments => { "$elemMatch" => { :text => "value" }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the fields are the same" do

        let(:selection) do
          query.
            elem_match(:users => { :name => "value" }).
            elem_match(:users => { :state => "new" })
        end

        it "overrides the $elemMatch expression" do
          selection.selector.should eq({
            :users => { "$elemMatch" => { :state => "new" }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#elem_match" do

      let(:key) do
        :field.elem_match
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selection::Key)
      end

      it "sets the name as the key" do
        key.name.should eq("field")
      end

      it "sets the operator as $elemMatch" do
        key.operator.should eq("$elemMatch")
      end
    end
  end
end
