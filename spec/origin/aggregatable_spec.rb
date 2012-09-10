require "spec_helper"

describe Origin::Aggregatable do

  let(:query) do
    Origin::Aggregation.new
  end

  describe "project" do
    context "when nil is provided" do
      let(:aggregation) { query.project nil }

      it "is empty" do
        aggregation.aggregator.should eq({ })
      end

    end

    context "when an array is provided" do
      context "with symbols" do
        let(:aggregation) { query.project [:author, :title]}

        it "projects all fields" do
          aggregation.aggregator.should eq({ "$project" => { "author" => 1, "title" => 1 } })
        end
      end
    end

    context "when a hash is provided" do
      context "with fields" do
        let(:aggregation) { query.project _id: false, author: 1, title: true, page_views: "$pageViews",  doctoredPageViews: { "$add" => ["$pageViews", 10] } }

        it "projects all fields" do
          aggregation.aggregator.should eq({ "$project" => { "_id" => 0, "author" => 1, "title" => 1, "page_views" => "$pageViews", "doctoredPageViews" => { "$add" => ["$pageViews", 10] } } })
        end

        it "returns a cloned query" do
          aggregation.should_not equal(query)
        end
      end
    end
  end

end
