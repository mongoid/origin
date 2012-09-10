require "spec_helper"

describe Origin::Aggregatable::ProjectParams do
  let(:hash) { described_class.new(param).hash }

  context "#hash" do
    context "when is an array" do
      let(:param) { [ :author, :title ] }

      it "returns a hash with project fields" do
        hash.should eq({ "author" => 1, "title" => 1 })
      end
    end

    context "when is a hash" do
      context "when values are numbers" do
        let(:param) { { author: 1, title: 1 } }

        it "returns a hash with project fields" do
          hash.should eq({ "author" => 1, "title" => 1 })
        end

        context "when one of the values is 0" do
          let(:param) { { _id: 0, author: 1 } }

          it "returns a hash with project fields" do
            hash.should eq({ "_id" => 0, "author" => 1 })
          end
        end
      end

      context "when values are booleans" do
        let(:param) { { "author" => true, :title => true } }

        it "returns a hash with project fields" do
          hash.should eq({ "author" => 1, "title" => 1 })
        end
      end

      context "when values are string" do
        let(:param) { { page_views: "$pageViews" } }

        it "returns a hash with project fields" do
          hash.should eq({ "page_views" => "$pageViews" })
        end
      end
    end
  end
end

