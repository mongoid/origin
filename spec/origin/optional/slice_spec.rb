require "spec_helper"

describe Origin::Optional::Slice do

  let(:query) do
    Origin::Query.new
  end

  describe "#slice" do

    context "when provided no options" do

      let(:selection) do
        query.slice
      end

      it "does not add any options" do
        selection.options.should eq({})
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
        query.slice(nil)
      end

      it "does not add any options" do
        selection.options.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided a single argument" do

      let(:selection) do
        query.slice(:first => 5)
      end

      it "adds the field options" do
        selection.options.should eq(
          { :fields => { :first => { "$slice" => 5 }}}
        )
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided a multiple arguments" do

      let(:selection) do
        query.slice(:first => 5, :second => [ 0, 3 ])
      end

      it "adds the field options" do
        selection.options.should eq({ :fields =>
          { :first => { "$slice" => 5 }, :second => { "$slice" => [ 0, 3 ] }}
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when existing field arguments exist" do

      let(:limited) do
        query.only(:name)
      end

      let(:selection) do
        limited.slice(:first => 5, :second => [ 0, 3 ])
      end

      it "adds the field options" do
        selection.options.should eq({
          :fields => {
            :name => 1,
            :first => { "$slice" => 5 },
            :second => { "$slice" => [ 0, 3 ] }
          }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end
  end
end
