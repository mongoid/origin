require "spec_helper"

describe Origin::Selector do

  describe "#overwrite" do

    let(:selector) do
      described_class.new
    end

    context "when the key is in the selector" do

      before do
        selector["field"] = "value"
      end

      let!(:overridden) do
        selector.overwrite(:field, "new")
      end

      it "returns the overridden value" do
        overridden.should eq("new")
      end

      it "overwrites the field" do
        selector["field"].should eq("new")
      end
    end

    context "when the key is not in the selector" do

      before do
        selector["field"] = "value"
      end

      let!(:overridden) do
        selector.overwrite(:key, "new")
      end

      it "returns the set value" do
        overridden.should eq("new")
      end

      it "sets the new field" do
        selector["key"].should eq("new")
      end
    end
  end
end
