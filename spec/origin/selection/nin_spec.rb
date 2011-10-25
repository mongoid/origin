require "spec_helper"

describe Origin::Selection::Nin do

  let(:query) do
    Origin::Query.new
  end

  describe "#nin" do

    context "when provided no criterion" do

      let(:selection) do
        query.nin
      end

      it "does not add any criterion" do
        selection.selector.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided nil" do

      let(:selection) do
        query.nin(nil)
      end

      it "does not add any criterion" do
        selection.selector.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided a sningle criterion" do

      let(:selection) do
        query.nin(:field => [ 1, 2 ])
      end

      it "adds the $nin selector" do
        selection.selector.should eq({
          :field => { "$nin" => [ 1, 2 ] }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.nin(:first => [ 1, 2 ], :second => [ 3, 4 ])
        end

        it "adds the $nin selectors" do
          selection.selector.should eq({
            :first => { "$nin" => [ 1, 2 ] },
            :second => { "$nin" => [ 3, 4 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaninning the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.nin(:first => [ 1, 2 ]).nin(:second => [ 3, 4 ])
        end

        it "adds the $nin selectors" do
          selection.selector.should eq({
            :first => { "$nin" => [ 1, 2 ] },
            :second => { "$nin" => [ 3, 4 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        context "when the stretegy is the default (intersection)" do

          let(:selection) do
            query.nin(:first => [ 1, 2 ]).nin(:first => [ 2, 3 ])
          end

          it "intersects the $nin selectors" do
            selection.selector.should eq({
              :first => { "$nin" => [ 2 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is intersect" do

          let(:selection) do
            query.nin(:first => [ 1, 2 ]).intersect.nin(:first => [ 2, 3 ])
          end

          it "intersects the $nin selectors" do
            selection.selector.should eq({
              :first => { "$nin" => [ 2 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is override" do

          let(:selection) do
            query.nin(:first => [ 1, 2 ]).override.nin(:first => [ 3, 4 ])
          end

          it "overwrites the first $nin selector" do
            selection.selector.should eq({
              :first => { "$nin" => [ 3, 4 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is union" do

          let(:selection) do
            query.nin(:first => [ 1, 2 ]).union.nin(:first => [ 3, 4 ])
          end

          it "unions the $nin selectors" do
            selection.selector.should eq({
              :first => { "$nin" => [ 1, 2, 3, 4 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end
    end
  end

  describe Symbol do

    describe "#nin" do

      let(:key) do
        :field.nin
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selection::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $nin" do
        key.operator.should eq("$nin")
      end
    end
  end
end
