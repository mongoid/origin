require "spec_helper"

describe Origin::Aggregatable::Match do

  describe "#name" do
    it { subject.name.should eq "$match" }
  end

  describe "#initialize" do

    shared_examples "match" do |params, expected|
      let(:subject) { described_class.new(params).operator }

      it { should eq expected }
    end

    context "with hash" do

      include_examples "match", { "author" => "dave" }, { "author" => "dave" }

    end

  end

end
