require "spec_helper"

describe Origin::Selector do

  describe "#__deep_copy__" do

    let(:value) do
      [ 1, 2, 3 ]
    end

    let(:selection) do
      { "$in" => value }
    end

    let(:selector) do
      described_class.new
    end

    before do
      selector[:field] = selection
    end

    let(:cloned) do
      selector.__deep_copy__
    end

    it "returns an equal copy" do
      cloned.should eq(selector)
    end

    it "performs a deep copy" do
      cloned[:field].should_not equal(selection)
    end

    it "clones n levels deep" do
      cloned[:field]["$in"].should_not equal(value)
    end
  end

  [ :store, :[]= ].each do |method|

    describe "##{method}" do

      context "when no serializers are provided" do

        let(:selector) do
          described_class.new
        end

        it "does not serialize values" do
          selector.send(method, "key", "5").should eq("5")
        end
      end

      context "when serializers are provided" do

        class Field
          def evolve(object)
            Integer.evolve(object)
          end
        end

        let(:selector) do
          described_class.new({ "key" => Field.new })
        end

        context "when the criterion is simple" do

          before do
            selector.send(method, "key", "5")
          end

          it "serializes the value" do
            selector["key"].should eq(5)
          end
        end
      end
    end
  end
end
