require "spec_helper"

describe Origin::Selector do

  describe "#__deep_copy__" do

    let(:value) do
      [ 1, 2, 3 ]
    end

    let(:selection) do
      { "$in" => value }
    end

    let(:selector) do
      described_class.new
    end

    before do
      selector[:field] = selection
    end

    let(:cloned) do
      selector.__deep_copy__
    end

    it "returns an equal copy" do
      cloned.should eq(selector)
    end

    it "performs a deep copy" do
      cloned[:field].should_not equal(selection)
    end

    it "clones n levels deep" do
      cloned[:field]["$in"].should_not equal(value)
    end
  end
end
