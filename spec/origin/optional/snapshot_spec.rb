require "spec_helper"

describe Origin::Optional::Snapshot do

  let(:query) do
    Origin::Query.new
  end

  describe "#snapshot" do

    let(:selection) do
      query.snapshot
    end

    it "adds the snapshot option" do
      selection.options.should eq({ snapshot: true })
    end
  end
end
