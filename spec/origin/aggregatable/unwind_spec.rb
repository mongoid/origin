require "spec_helper"

describe Origin::Aggregatable::Unwind do

  describe "#name" do
    it { subject.name.should eq "$unwind" }
  end

  describe "#initialize" do

    context "when string is provided" do

      let(:subject) { described_class.new("tags").operator }

      it { should eq "$tags" }

    end

    context "when symbol is provided" do

      let(:subject) { described_class.new(:tags).operator }

      it { should eq "$tags"}

    end

  end

end
