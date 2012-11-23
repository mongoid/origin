require "spec_helper"

describe Origin::Aggregator do

  describe "#<<" do
    context "when nil is provided" do
      before { subject <<  nil }

      it { should be_empty }
    end

    context "when something different than operation is provided" do
      before { subject << {} }

      it { should be_empty }
    end

    context "when a Project is provided" do
      let(:project) { Origin::Aggregatable::Project.new( { "author" => 1, "title" => 1 } ) }

      before { subject << project }

      it "adds a project operator" do
        should eq [ {  "$project" => { "author" => 1, "title" => 1 } } ]
      end
    end

    context "when Match is provded" do
      let(:match) { Origin::Aggregatable::Match.new( { "author" => "dave" } ) }

      before { subject << match }

      it "adds a match operator" do
        should eq [ { "$match" => { "author" => "dave" } } ]
      end
    end

    context "when Limit is provided" do
      let(:operator) { Origin::Aggregatable::Limit.new(10) }

      before { subject << operator }

      it "adds a limit operator" do
        should eq [ { "$limit" => 10 } ]
      end
    end

    context "when Skip is provided" do
      let(:operator) { Origin::Aggregatable::Skip.new(15) }

      before { subject << operator }

      it "adds a skip operator" do
        should eq [ { "$skip" => 15} ]
      end
    end

    context "when Unwind is provided" do
      let(:operator) { Origin::Aggregatable::Unwind.new("tags") }

      before { subject << operator }

      it "adds an unwind operator" do
        should eq [ { "$unwind" => "$tags" } ]
      end
    end

    context "when Group is provided" do
      let(:operator) { Origin::Aggregatable::Group.new({ "author" => "$author" }) }

      before { subject << operator }

      it "adds a group operator" do
        should eq [ { "$group" => { "author" => "$author" } } ]
      end
    end

    context "when a Sort is provided" do
      let(:operator) { Origin::Aggregatable::Sort.new( { "age" => -1, "post" => 1 } ) }

      before { subject << operator }

      it "adds sort operator" do
        should eq [ { "$sort" => { "age" => -1, "post" => 1 } } ]
      end
    end
  end

end
