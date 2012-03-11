require "spec_helper"

describe Origin::Optional::NoTimeout do

  let(:query) do
    Origin::Query.new
  end

  describe "#no_timeout" do

    let(:selection) do
      query.no_timeout
    end

    it "adds the timeout option" do
      selection.options.should eq({ "timeout" => false })
    end
  end
end
