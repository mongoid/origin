require "spec_helper"

describe Origin::Pipeline do

  describe "#__deep_copy" do

    let(:project) do
      { "$project" => { "name" => 1 }}
    end

    let(:pipeline) do
      described_class.new
    end

    before do
      pipeline.push(project)
    end

    let(:copied) do
      pipeline.__deep_copy__
    end

    it "clones all the objects in the pipeline" do
      expect(copied.first).to_not equal(project)
    end

    it "clones the pipeline" do
      expect(copied).to_not equal(pipeline)
    end
  end

  describe "#group" do

    context "when the expression fields are not aliased" do

      let(:pipeline) do
        described_class.new
      end

      context "when using full notation" do

        before do
          pipeline.group(count: { "$sum" => 1 }, max: { "$max" => "likes" })
        end

        it "adds the group operation to the pipeline" do
          expect(pipeline).to eq([
            { "$group" => { "count" => { "$sum" => 1 }, "max" => { "$max" => "likes" }}}
          ])
        end
      end

      context "when using symbol shortcuts" do

        before do
          pipeline.group(:count.sum => 1, :max.max => "likes")
        end

        it "adds the group operation to the pipeline" do
          expect(pipeline).to eq([
            { "$group" => { "count" => { "$sum" => 1 }, "max" => { "$max" => "likes" }}}
          ])
        end
      end
    end
  end

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
