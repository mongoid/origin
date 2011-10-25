require "spec_helper"

describe Origin::Selector do

  describe "#intersect!" do

    let(:selector) do
      described_class.new
    end

    context "when the field does not exist" do

      let!(:intersect) do
        selector.intersect!(:field, "$in", [ 1, 2 ])
      end

      it "sets the value" do
        selector.should eq({ :field => { "$in" => [ 1, 2 ]}})
      end

      it "returns the new value" do
        intersect.should eq({ "$in" => [ 1, 2 ]})
      end
    end

    context "when the field exists" do

      context "when the field has no operator" do

        context "when the field is an array" do

          before do
            selector[:field] = [ 1, 2 ]
          end

          let!(:intersect) do
            selector.intersect!(:field, "$in", [ 2, 3 ])
          end

          it "intersects the values" do
            selector.should eq({ :field => { "$in" => [ 2 ]}})
          end

          it "returns the new value" do
            intersect.should eq({ "$in" => [ 2 ] })
          end
        end

        context "when the field is not an array" do

          before do
            selector[:field] = 2
          end

          let!(:intersect) do
            selector.intersect!(:field, "$in", [ 2, 3 ])
          end

          it "intersects the values" do
            selector.should eq({ :field => { "$in" => [ 2 ]}})
          end

          it "returns the new value" do
            intersect.should eq({ "$in" => [ 2 ] })
          end
        end
      end

      context "when the field has the same operator" do

        before do
          selector[:field] = { "$in" => [ 1, 2 ] }
        end

        let!(:intersect) do
          selector.intersect!(:field, "$in", [ 2, 3 ])
        end

        it "intersects the values" do
          selector.should eq({ :field => { "$in" => [ 2 ]}})
        end

        it "returns the new value" do
          intersect.should eq({ "$in" => [ 2 ] })
        end
      end

      context "when the field has a different operator" do

        before do
          selector[:field] = { "$all" => [ 1, 2 ] }
        end

        let!(:intersect) do
          selector.intersect!(:field, "$in", [ 2, 3 ])
        end

        it "overrides the previous operator" do
          selector.should eq({ :field => { "$in" => [ 2, 3 ]}})
        end

        it "returns the new value" do
          intersect.should eq({ "$in" => [ 2, 3 ] })
        end
      end
    end
  end

  describe "#override!" do

    let(:selector) do
      described_class.new
    end

    context "when the field does not exist" do

      let!(:override) do
        selector.override!(:field, "$in", [ 1, 2 ])
      end

      it "sets the value" do
        selector.should eq({ :field => { "$in" => [ 1, 2 ]}})
      end

      it "returns the new value" do
        override.should eq({ "$in" => [ 1, 2 ]})
      end
    end

    context "when the field exists" do

      context "when the field has no operator" do

        context "when the field is an array" do

          before do
            selector[:field] = [ 1, 2 ]
          end

          let!(:override) do
            selector.override!(:field, "$in", [ 2, 3 ])
          end

          it "overrides the values" do
            selector.should eq({ :field => { "$in" => [ 2, 3 ]}})
          end

          it "returns the new value" do
            override.should eq({ "$in" => [ 2, 3 ] })
          end
        end

        context "when the field is not an array" do

          before do
            selector[:field] = 2
          end

          let!(:override) do
            selector.override!(:field, "$in", [ 2, 3 ])
          end

          it "overrides the values" do
            selector.should eq({ :field => { "$in" => [ 2, 3 ]}})
          end

          it "returns the new value" do
            override.should eq({ "$in" => [ 2, 3 ] })
          end
        end
      end

      context "when the field has the same operator" do

        before do
          selector[:field] = { "$in" => [ 1, 2 ] }
        end

        let!(:override) do
          selector.override!(:field, "$in", [ 2, 3 ])
        end

        it "overrides the values" do
          selector.should eq({ :field => { "$in" => [ 2, 3 ]}})
        end

        it "returns the new value" do
          override.should eq({ "$in" => [ 2, 3 ] })
        end
      end

      context "when the field has a different operator" do

        before do
          selector[:field] = { "$all" => [ 1, 2 ] }
        end

        let!(:override) do
          selector.override!(:field, "$in", [ 2, 3 ])
        end

        it "overrides the previous operator" do
          selector.should eq({ :field => { "$in" => [ 2, 3 ]}})
        end

        it "returns the new value" do
          override.should eq({ "$in" => [ 2, 3 ] })
        end
      end
    end
  end

  describe "#union!" do

    let(:selector) do
      described_class.new
    end

    context "when the field does not exist" do

      let!(:union) do
        selector.union!(:field, "$in", [ 1, 2 ])
      end

      it "sets the value" do
        selector.should eq({ :field => { "$in" => [ 1, 2 ]}})
      end

      it "returns the new value" do
        union.should eq({ "$in" => [ 1, 2 ]})
      end
    end

    context "when the field exists" do

      context "when the field has no operator" do

        context "when the field is an array" do

          before do
            selector[:field] = [ 1, 2 ]
          end

          let!(:union) do
            selector.union!(:field, "$in", [ 2, 3 ])
          end

          it "unions the values" do
            selector.should eq({ :field => { "$in" => [ 1, 2, 3 ]}})
          end

          it "returns the new value" do
            union.should eq({ "$in" => [ 1, 2, 3 ] })
          end
        end

        context "when the field is not an array" do

          before do
            selector[:field] = 1
          end

          let!(:union) do
            selector.union!(:field, "$in", [ 2, 3 ])
          end

          it "unions the values" do
            selector.should eq({ :field => { "$in" => [ 1, 2, 3 ]}})
          end

          it "returns the new value" do
            union.should eq({ "$in" => [ 1, 2, 3 ] })
          end
        end
      end

      context "when the field has the same operator" do

        before do
          selector[:field] = { "$in" => [ 1, 2 ] }
        end

        let!(:union) do
          selector.union!(:field, "$in", [ 2, 3 ])
        end

        it "unions the values" do
          selector.should eq({ :field => { "$in" => [ 1, 2, 3 ]}})
        end

        it "returns the new value" do
          union.should eq({ "$in" => [ 1, 2, 3 ] })
        end
      end

      context "when the field has a different operator" do

        before do
          selector[:field] = { "$all" => [ 1, 2 ] }
        end

        let!(:union) do
          selector.union!(:field, "$in", [ 2, 3 ])
        end

        it "overrides the previous operator" do
          selector.should eq({ :field => { "$in" => [ 2, 3 ]}})
        end

        it "returns the new value" do
          union.should eq({ "$in" => [ 2, 3 ] })
        end
      end
    end
  end
end
