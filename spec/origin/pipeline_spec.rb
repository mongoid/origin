require "spec_helper"

describe Origin::Pipeline do

  describe "#initialize" do

    context "when provided aliases" do

      let(:aliases) do
        { "id" => "_id" }
      end

      let(:pipeline) do
        described_class.new(aliases)
      end

      it "sets the aliases" do
        expect(pipeline.aliases).to eq(aliases)
      end
    end

    context "when not provided aliases" do

      let(:pipeline) do
        described_class.new
      end

      it "sets the aliases to an empty hash" do
        expect(pipeline.aliases).to be_empty
      end
    end
  end
end
