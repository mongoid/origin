require "spec_helper"

describe Origin::Aggregator do

  let(:aggregator) { Origin::Aggregator.new }

  describe "#project" do
    context "when no project exists" do
      it "returns an empty hash" do
        aggregator.project.should be_empty
      end
    end

    context "when project exists" do
      before do
        aggregator.project.merge!({ "author" => 1 })
        aggregator.project["title"] = 1
      end

      it "returns the current project hash" do
        aggregator.project.should eq({ "author" => 1, "title" => 1})
      end
    end
  end

end
