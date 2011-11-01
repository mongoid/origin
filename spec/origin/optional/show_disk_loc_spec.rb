require "spec_helper"

describe Origin::Optional::ShowDiskLoc do

  let(:query) do
    Origin::Query.new
  end

  describe "#show_disk_loc" do

    let(:selection) do
      query.show_disk_loc
    end

    it "adds the timeout option" do
      selection.options.should eq({ :show_disk_loc => true })
    end
  end
end
