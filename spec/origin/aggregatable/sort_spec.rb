require 'spec_helper'

describe Origin::Aggregatable::Sort do

  describe "#name" do
    it { subject.name.should eq "$sort" }
  end

  describe "#initialize" do

    let(:subject) { described_class.new(params).operator }

    context "when a hash is provided" do

      let(:expected) { { "age" => -1, "post" => 1} }

      context "with integer as value" do

        let(:params) { { "age" => -1, "post" => 1 } }

        it { should eq expected }

      end

      context "with symbol as values" do

        let(:params) { { "age" => :desc, "post" => :asc } }

        it { should eq expected }

      end

      context "with symbol as keys" do

        let(:params) { { age: :desc, post: :asc } }

        it { should eq expected }

      end

    end

    context "when a list is provided" do

      context "with strings" do

        let(:params) { [ "age", "post" ] }

        it { should eq( { "age" => 1, "post" => 1} ) }

      end

      context "with symbols" do

        let(:params) { [ :age, :post  ] }

        it { should eq( { "age" => 1, "post" => 1} ) }

      end

    end

    context "when a string is provided" do

      let(:params) { "age" }

      it { should eq( { "age" => 1 } ) }

    end

    context "when a symbol is provided" do

      let(:params) { :age }

      it { should eq( { "age" => 1 } ) }

    end

  end

end
