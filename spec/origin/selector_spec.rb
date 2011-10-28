require "spec_helper"

describe Origin::Selector do

  describe "#append!" do

    let(:selector) do
      described_class.new
    end

    context "when the field does not exist" do

      let!(:append) do
        selector.append!(:field, "$maxDistance", 10)
      end

      it "sets the value" do
        selector.should eq({ :field => { "$maxDistance" => 10 }})
      end

      it "returns the attempted value" do
        append.should eq({ "$maxDistance" => 10 })
      end
    end

    context "when the field exists" do

      before do
        selector[:field] = { "$near" => [ 20, 20 ] }
      end

      let!(:append) do
        selector.append!(:field, "$maxDistance", 10)
      end

      it "appends the value to the selector" do
        selector.should eq(
          { :field => { "$near" => [ 20, 20 ], "$maxDistance" => 10 }}
        )
      end

      it "returns the selector" do
        append.should eq({ "$near" => [ 20, 20 ], "$maxDistance" => 10 })
      end
    end
  end

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
