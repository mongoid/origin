require "spec_helper"

describe Origin::Aggregatable do

  let(:query) do
    Origin::Aggregation.new
  end

  describe Origin::Aggregatable::ProjectParams do
    context "#hash" do
      context "when is an array" do
        let(:params) { Origin::Aggregatable::ProjectParams.new([:author, :title]).hash }

        it "projects all fields" do
          params.should eq({ "author" => 1, "title" => 1 })
        end
      end
    end
  end

  describe "project" do
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
        let(:aggregation) { query.project author: 1, title: 1 }

        it "projects all fields" do
          aggregation.aggregator.should eq({ "$project" => { "author" => 1, "title" => 1 } })
        end

        it "returns a cloned query" do
          aggregation.should_not equal(query)
        end
      end

      context "with id to be removed" do
        let(:aggregation) { query.project _id: 0, author: 1 }

        it "projects with 0" do
          aggregation.aggregator.should eq({ "$project" => {"_id" => 0, "author" => 1} })
        end

        it "returns a cloned query" do
          aggregation.should_not equal(query)
        end
      end

      context "with a field to be renamed" do
        let(:aggregation) { query.project page_views: "$pageViews" }

        it "projects renamed field" do
          aggregation.aggregator.should eq( { "$project" => { "page_views" => "$pageViews" } } )
        end

        it "returns a cloned query" do
          aggregation.should_not equal(query)
        end
      end

      context "with a computed field" do
        let(:aggregation) { query.project doctoredPageViews: { "$add" => ["$pageViews", 10] } }

        it "projects a computed field" do
          aggregation.aggregator.should eq( { "$project" => { "doctoredPageViews" => { "$add" => ["$pageViews", 10] } } } )
        end

        it "returns a cloned query" do
          aggregation.should_not equal(query)
        end
      end



    end


  end


end
