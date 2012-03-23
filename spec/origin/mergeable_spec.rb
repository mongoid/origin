require "spec_helper"

describe Origin::Mergeable do

  describe "#intersect" do

    let(:query) do
      Origin::Query.new
    end

    before do
      query.intersect
    end

    it "sets the strategy to intersect" do
      query.strategy.should eq(:__intersect__)
    end
  end

  describe "#override" do

    let(:query) do
      Origin::Query.new
    end

    before do
      query.override
    end

    it "sets the strategy to override" do
      query.strategy.should eq(:__override__)
    end
  end

  describe "#union" do

    let(:query) do
      Origin::Query.new
    end

    before do
      query.union
    end

    it "sets the strategy to union" do
      query.strategy.should eq(:__union__)
    end
  end
end
