require "spec_helper"

describe Origin::Aggregator do

  let(:aggregator) { Origin::Aggregator.new }

  describe "#project" do
    context "when nil is provided" do
      before { aggregator.project( nil ) }

      it "keeps the array empty" do
        aggregator.should be_empty
      end
    end

    context "when hash is provided" do
      before { aggregator.project( { "author" => 1, "title" => 1 } ) }

      it "adds a project operator" do
        aggregator.should eq [ {  "$project" => { "author" => 1, "title" => 1 } } ]
      end
    end
  end

  describe "#match" do
    context "when nil is provided"  do
      before { aggregator.match nil }

      it "keeps the array empty" do
        aggregator.should be_empty
      end
    end

    context "when hash is provded" do
      before { aggregator.match( { "author" => "dave" } ) }

      it "adds a match operator" do
        aggregator.should eq [ { "$match" => { "author" => "dave" } } ]
      end
    end
  end

  describe "#limit" do
    context "when nil is provided" do
      before { aggregator.limit nil }

      it "keeps the array empty" do
        aggregator.should be_empty
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

      it "keeps the array empty" do
        aggregator.should be_empty
      end
    end

    context "when value is provided" do
      before { aggregator.skip 15 }

      it "adds a skip operator" do
        aggregator.should eq [ { "$skip" => 15} ]
      end
    end
  end

  describe "#unwind" do
    context "when nil is provided" do
      before { aggregator.unwind(nil) }

      it "keeps the array empty" do
        aggregator.should be_empty
      end
    end

    context "when field name is provided" do
      before { aggregator.unwind "tags" }

      it "adds an unwind operator" do
        aggregator.should eq [ { "$unwind" => "$tags" } ]
      end
    end

    context "when field name as symbol is provided" do
      before { aggregator.unwind :tags }

      it "adds an unwind operator" do
        aggregator.should eq [ { "$unwind" => "$tags" } ]
      end
    end
  end

  describe "#sort" do
    context "when nil is provided" do
      before { aggregator.sort(nil) }

      it "keeps the array empty" do
        aggregator.should be_empty
      end
    end

    context "when a hash is provided" do
      before { aggregator.sort( { "age" => -1, "post" => 1 } ) }

      it "adds sort operator" do
        aggregator.should eq [ { "$sort" => { "age" => -1, "post" => 1 } } ]
      end
    end
  end

end
