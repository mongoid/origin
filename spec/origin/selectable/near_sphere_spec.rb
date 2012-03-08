require "spec_helper"

describe Origin::Selectable::NearSphere do

  let(:query) do
    Origin::Query.new
  end

  describe "#near_sphere" do

    context "when provided no criterion" do

      let(:selection) do
        query.near_sphere
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
        query.near_sphere(nil)
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
        query.near_sphere(location: [ 20, 21 ])
      end

      it "adds the $nearSphere expression" do
        selection.selector.should eq({
          "location" =>  { "$nearSphere" => [ 20, 21 ] }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.near_sphere(
            location: [ 20, 21 ],
            comments: [ 20, 21 ]
          )
        end

        it "adds the $nearSphere expression" do
          selection.selector.should eq({
            "location" =>  { "$nearSphere" => [ 20, 21 ] },
            "comments" =>  { "$nearSphere" => [ 20, 21 ] }
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
            near_sphere(location: [ 20, 21 ]).
            near_sphere(comments: [ 20, 21 ])
        end

        it "adds the $nearSphere expression" do
          selection.selector.should eq({
            "location" =>  { "$nearSphere" => [ 20, 21 ] },
            "comments" =>  { "$nearSphere" => [ 20, 21 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#near_sphere" do

      let(:key) do
        :field.near_sphere
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $nearSphere" do
        key.operator.should eq("$nearSphere")
      end
    end
  end
end
