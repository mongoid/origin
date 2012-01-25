require "spec_helper"

describe Integer do

  describe ".evolve" do

    context "when provided a string" do

      context "when the string is a number" do

        context "when the string is an integer" do

          it "returns an integer" do
            described_class.evolve("1").should eq(1)
          end
        end

        context "when the string is a float" do

          it "converts it to a float" do
            described_class.evolve("2.23").should eq(2.23)
          end
        end
      end

      context "when the string is not a number" do

        it "returns the string" do
          described_class.evolve("testing").should eq("testing")
        end
      end
    end
  end
end
