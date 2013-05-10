require "spec_helper"

describe Origin::Aggregatable::Skip do

  describe "#name" do
    it { subject.name.should eq "$skip" }
  end

  context "#initialize" do

    let(:subject) { described_class.new(15).operator }

    it { should eq 15}

  end

end
