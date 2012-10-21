require "spec_helper"

describe Origin::Aggregator do

  let(:aggregator) { Origin::Aggregator.new }

  describe "#project" do
    context "when nil is provided" do
      before { aggregator.project( nil ) }

      it "keeps the array empty" do
        aggregator.should eq []
      end
    end

    context "when hash is provided" do
      before { aggregator.project( { "author" => 1, "title" => 1 } ) }

      it "adds a project operator" do
        aggregator.should eq [ {  "$project" => { "author" => 1, "title" => 1 } } ]
      end
    end
  end

  describe "#limit" do
    context "when nil is provided" do
      before { aggregator.limit nil }

      it "keeps the array empty" do
        aggregator.should eq []
      end
    end

    context "when value is provided" do
      before { aggregator.limit 10 }

      it "adds a limit operator" do
        aggregator.should eq [ { "$limit" => 10 } ]
      end
    end
  end

  describe "#skip" do
    context "when nil is provided" do
      before { aggregator.skip(nil) }

      it "adds a skip operator" do
        aggregator.should eq []
      end
    end

    context "when value is provided" do
      before { aggregator.skip 15 }

      it "adds a skip operator" do
        aggregator.should eq [ { "$skip" => 15} ]
      end
    end
  end

end
