require "spec_helper"

describe Origin::Aggregatable do

  let(:query) do
    Origin::Aggregation.new
  end

  shared_examples "when nil is provided" do |method|
    context "when nil is provided" do
      let(:aggregation) { query.send(method, nil) }

      it "is empty" do
        aggregation.aggregator.should eq []
      end

      it "returns a cloned query" do
        aggregation.should_not equal query
      end
    end
  end

  describe "#project" do
    include_examples "when nil is provided", :project

    context "when an array is provided" do
      context "with symbols" do
        let(:aggregation) { query.project [:author, :title]}

        it "projects all fields" do
          aggregation.aggregator.should eq([{ "$project" => { "author" => 1, "title" => 1 } }])
        end

        it "returns a cloned query" do
          aggregation.should_not equal query
        end
      end
    end
  end

  describe "#match" do
    include_examples "when nil is provided", :match

    context "when a hash is provided" do
      let(:aggregation) { query.match( { "author" => "dave" } ) }

      it "matches fields" do
        aggregation.aggregator.should eq([ { "$match" => { "author" => "dave" } } ])
      end

      it "returns a cloned query" do
        aggregation.should_not equal query
      end
    end
  end

  describe "#limit" do
    include_examples "when nil is provided", :limit

    context "when integer is provided" do
      let :aggregation do
        query.limit(10)
      end

      it "limits aggregation" do
        aggregation.aggregator.should eq( [ { "$limit" => 10 } ] )
      end

      it "returns a cloned query" do
        aggregation.should_not equal(query)
      end
    end
  end

  describe "#skip" do
    include_examples "when nil is provided", :skip

    context "when integer is provided" do
      let(:aggregation) { query.skip(15) }

      it "add skip to aggregation" do
        aggregation.aggregator.should eq [ { "$skip" => 15 } ]
      end

      it "returns a cloned query" do
        aggregation.should_not equal(query)
      end
    end
  end

  describe "#unwind" do
    include_examples "when nil is provided", :unwind

    context "when symbol is provided" do
      let(:aggregation) { query.unwind :tags }

      it "add unwind to aggregation" do
        aggregation.aggregator.should eq [ { "$unwind" => "$tags" }  ]
      end

      it "returns a cloned query" do
        aggregation.aggregator.should_not equal(query)
      end
    end
  end

  describe "#group" do
    include_examples "when nil is provided", :group

    context "when a hash is provided" do
      let(:aggregation) { query.group({ "author" => "$author" })}

      it "add group to aggregation" do
        aggregation.aggregator.should eq [ { "$group" => { "author" => "$author" } } ]
      end

      it "returns a cloned query" do
        aggregation.aggregator.should_not equal(query)
      end
    end
  end

  describe "#sort" do
    include_examples "when nil is provided", :sort

    context "when hash is provided" do
      let(:aggregation) { query.sort( { "age" => -1 } ) }

      it "add sort operator to aggregation" do
        aggregation.aggregator.should eq [ { "$sort" => { "age" => -1 } } ]
      end

      it "returns a cloned query" do
        aggregation.aggregator.should_not equal query
      end
    end
  end

end
