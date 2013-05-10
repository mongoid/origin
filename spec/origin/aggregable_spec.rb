require "spec_helper"

describe Origin::Aggregable do

  let(:query) do
    Origin::Query.new("id" => "_id")
  end

  describe "#project" do

    shared_examples_for "an aggregable object" do

      it "clones the queryable" do
        expect(aggregation).to_not equal(query)
      end

      it "sets the aggrating flag" do
        expect(aggregation).to be_aggregating
      end
    end

    context "when no selection or options exist" do

      let(:aggregation) do
        query.project(author: 1, title: 0)
      end

      let!(:pipeline) do
        aggregation.pipeline
      end

      it "sets the projection" do
        expect(pipeline).to eq([
          { "$project" => { "author" => 1, "title" => 0 }}
        ])
      end

      it_behaves_like "an aggregable object"
    end

    context "when the field is aliased" do

      let(:aggregation) do
        query.project(id: 1, title: 0)
      end

      let!(:pipeline) do
        aggregation.pipeline
      end

      it "sets the aliased projection" do
        expect(pipeline).to eq([
          { "$project" => { "_id" => 1, "title" => 0 }}
        ])
      end

      it_behaves_like "an aggregable object"
    end

    context "when selection exists" do

      let(:aggregation) do
        query.where(name: "test").project(author: 1, title: 0)
      end

      let!(:pipeline) do
        aggregation.pipeline
      end

      it "converts the selection to a $match" do
        expect(pipeline).to eq([
          { "$match" => { "name" => "test" }},
          { "$project" => { "author" => 1, "title" => 0 }}
        ])
      end

      it_behaves_like "an aggregable object"
    end

    context "when options exist" do

      context "when the option is a sort" do

        let(:aggregation) do
          query.asc(:name).project(author: 1, title: 0)
        end

        let!(:pipeline) do
          aggregation.pipeline
        end

        it "converts the option to a $sort" do
          expect(pipeline).to eq([
            { "$sort" => { "name" => 1 }},
            { "$project" => { "author" => 1, "title" => 0 }}
          ])
        end

        it_behaves_like "an aggregable object"
      end

      context "when the option is a limit" do

        let(:aggregation) do
          query.limit(10).project(author: 1, title: 0)
        end

        let!(:pipeline) do
          aggregation.pipeline
        end

        it "converts the option to a $sort" do
          expect(pipeline).to eq([
            { "$limit" => 10 },
            { "$project" => { "author" => 1, "title" => 0 }}
          ])
        end

        it_behaves_like "an aggregable object"
      end

      context "when the option is a skip" do

        let(:aggregation) do
          query.skip(10).project(author: 1, title: 0)
        end

        let!(:pipeline) do
          aggregation.pipeline
        end

        it "converts the option to a $sort" do
          expect(pipeline).to eq([
            { "$skip" => 10 },
            { "$project" => { "author" => 1, "title" => 0 }}
          ])
        end

        it_behaves_like "an aggregable object"
      end
    end

    context "when selection and options exist" do

      let(:aggregation) do
        query.skip(10).where(name: "test").project(author: 1, title: 0)
      end

      let!(:pipeline) do
        aggregation.pipeline
      end

      it "converts the option to a $sort" do
        expect(pipeline).to eq([
          { "$match" => { "name" => "test" }},
          { "$skip" => 10 },
          { "$project" => { "author" => 1, "title" => 0 }}
        ])
      end

      it_behaves_like "an aggregable object"
    end
  end

  describe "#unwind" do

  end

  describe "#group" do

  end
end
