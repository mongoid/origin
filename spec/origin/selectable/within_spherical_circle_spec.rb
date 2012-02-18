require "spec_helper"

describe Origin::Selectable::WithinSphericalCircle do

  let(:query) do
    Origin::Query.new
  end

  describe "#within_spherical_circle" do

    context "when provided no criterion" do

      let(:selection) do
        query.within_spherical_circle
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
        query.within_spherical_circle(nil)
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

    context "when provided a criterion" do

      let(:selection) do
        query.within_spherical_circle(location: [[ 1, 10 ], 25 ])
      end

      it "adds the $within expression" do
        selection.selector.should eq({
          location: { "$within" => { "$centerSphere" => [[ 1, 10 ], 25 ] }}
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.within_spherical_circle(
            location: [[ 1, 10 ], 25 ],
            comments: [[ 1, 10 ], 25 ]
          )
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            location: { "$within" => { "$centerSphere" => [[ 1, 10 ], 25 ] }},
            comments: { "$within" => { "$centerSphere" => [[ 1, 10 ], 25 ] }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.
            within_spherical_circle(location: [[ 1, 10 ], 25 ]).
            within_spherical_circle(comments: [[ 1, 10 ], 25 ])
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            location: { "$within" => { "$centerSphere" => [[ 1, 10 ], 25 ] }},
            comments: { "$within" => { "$centerSphere" => [[ 1, 10 ], 25 ] }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#within_spherical_circle" do

      let(:key) do
        :field.within_spherical_circle
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $within" do
        key.operator.should eq("$within")
      end

      it "sets the expanded operator as $centerSphere" do
        key.expanded.should eq("$centerSphere")
      end
    end
  end
end
