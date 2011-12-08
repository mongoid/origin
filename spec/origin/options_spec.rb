require "spec_helper"

describe Origin::Options do

  describe "#deep_copy" do

    let(:sort) do
      [[ :name, :asc ]]
    end

    let(:options) do
      described_class.new
    end

    before do
      options[:sort] = sort
    end

    let(:cloned) do
      options.deep_copy
    end

    it "returns an equal copy" do
      cloned.should eq(options)
    end

    it "performs a deep copy" do
      cloned[:sort].should_not equal(sort)
    end
  end
end
