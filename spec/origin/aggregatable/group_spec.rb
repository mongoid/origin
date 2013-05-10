require "spec_helper"

describe Origin::Aggregatable::Group do

  describe "#name" do
    it { subject.name.should eq "$group"}
  end

  describe "#initialize" do

    context "when a hash is provided" do

      let(:subject) { described_class.new({ "author" => "author" }).operator }

      it { should eq( { "author" => "author" } ) }

    end

  end

end
