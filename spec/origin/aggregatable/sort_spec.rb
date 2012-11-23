require 'spec_helper'

describe Origin::Aggregatable::Sort do

  describe "#name" do
    it { subject.name.should eq "$sort" }
  end

  describe "#initialize" do

    let(:subject) { described_class.new( "age" => -1, "post" => 1 ).operator }

    it { should eq( { "age" => -1, "post" => 1} ) }

  end



end
