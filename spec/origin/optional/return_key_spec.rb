require "spec_helper"

describe Origin::Optional::ReturnKey do

  let(:query) do
    Origin::Query.new
  end

  describe "#return_key" do

    let(:selection) do
      query.return_key
    end

    it "adds the timeout option" do
      selection.options.should eq({ :return_key => true })
    end
  end
end
