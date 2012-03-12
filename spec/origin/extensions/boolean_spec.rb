require "spec_helper"

describe Boolean do

  describe ".evolve" do

    context "when provided a boolean" do

      context "when provided true" do

        it "returns true" do
          described_class.evolve(true).should eq(true)
        end
      end

      context "when provided false" do

        it "returns false" do
          described_class.evolve(false).should eq(false)
        end
      end
    end

    context "when provided a string" do

      context "when provided true" do

        it "returns true" do
          described_class.evolve("true").should eq(true)
        end
      end

      context "when provided t" do

        it "returns true" do
          described_class.evolve("t").should eq(true)
        end
      end

      context "when provided 1" do

        it "returns true" do
          described_class.evolve("1").should eq(true)
        end
      end

      context "when provided 1.0" do

        it "returns true" do
          described_class.evolve("1.0").should eq(true)
        end
      end

      context "when provided yes" do

        it "returns true" do
          described_class.evolve("yes").should eq(true)
        end
      end

      context "when provided y" do

        it "returns true" do
          described_class.evolve("y").should eq(true)
        end
      end

      context "when provided false" do

        it "returns false" do
          described_class.evolve("false").should eq(false)
        end
      end

      context "when provided f" do

        it "returns false" do
          described_class.evolve("f").should eq(false)
        end
      end

      context "when provided 0" do

        it "returns false" do
          described_class.evolve("0").should eq(false)
        end
      end

      context "when provided 0.0" do

        it "returns false" do
          described_class.evolve("0.0").should eq(false)
        end
      end

      context "when provided no" do

        it "returns false" do
          described_class.evolve("no").should eq(false)
        end
      end

      context "when provided n" do

        it "returns false" do
          described_class.evolve("n").should eq(false)
        end
      end
    end
  end

  context "when provided an array" do

    context "when provided a string" do

      context "when provided true" do

        it "returns true" do
          described_class.evolve([ "true" ]).should eq([ true ])
        end
      end

      context "when provided t" do

        it "returns true" do
          described_class.evolve([ "t" ]).should eq([ true ])
        end
      end

      context "when provided 1" do

        it "returns true" do
          described_class.evolve([ "1" ]).should eq([ true ])
        end
      end

      context "when provided 1.0" do

        it "returns true" do
          described_class.evolve([ "1.0" ]).should eq([ true ])
        end
      end

      context "when provided yes" do

        it "returns true" do
          described_class.evolve([ "yes" ]).should eq([ true ])
        end
      end

      context "when provided y" do

        it "returns true" do
          described_class.evolve([ "y" ]).should eq([ true ])
        end
      end

      context "when provided false" do

        it "returns false" do
          described_class.evolve([ "false" ]).should eq([ false ])
        end
      end

      context "when provided f" do

        it "returns false" do
          described_class.evolve([ "f" ]).should eq([ false ])
        end
      end

      context "when provided 0" do

        it "returns false" do
          described_class.evolve([ "0" ]).should eq([ false ])
        end
      end

      context "when provided 0.0" do

        it "returns false" do
          described_class.evolve([ "0.0" ]).should eq([ false ])
        end
      end

      context "when provided no" do

        it "returns false" do
          described_class.evolve([ "no" ]).should eq([ false ])
        end
      end

      context "when provided n" do

        it "returns false" do
          described_class.evolve([ "n" ]).should eq([ false ])
        end
      end
    end
  end
end
