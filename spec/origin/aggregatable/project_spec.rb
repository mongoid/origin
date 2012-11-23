require "spec_helper"

describe Origin::Aggregatable::Project do

  describe "#name" do
    it { subject.name.should eq "$project" }
  end

  describe "#initialize" do

    shared_examples "project" do |params, expected|
      let(:subject) { described_class.new(params).operator }

      it { should eq expected }
    end

    context "with array" do
      include_examples "project", [ :author, :title ], { "author" => 1, "title" => 1 }
    end

    context "with hash" do
      context "when values are numbers" do

        include_examples "project", { author: 1, title: 1 }, { "author" => 1, "title" => 1 }

      end

      context "when one of the values is 0" do

        include_examples "project", { _id: 0, author: 1 }, { "_id" => 0, "author" => 1 }

      end

      context "when values are booleans" do

        include_examples "project", { "author" => true, :title => true }, { "author" => 1, "title" => 1 }

      end

      context "when values are string" do

        include_examples "project", { page_views: "$pageViews" }, { "page_views" => "$pageViews" }

      end

    end

  end

end
