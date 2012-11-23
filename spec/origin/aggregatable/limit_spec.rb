require "spec_helper"

describe Origin::Aggregatable::Limit do

  describe "#name" do
    it { subject.name.should eq "$limit" }
  end

  describe "#initialize" do
    context "with integer" do
      let(:subject) { described_class.new(10).operator }

      it { should eq 10 }
    end
  end


end
