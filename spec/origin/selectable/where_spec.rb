require "spec_helper"

describe Origin::Selectable::Where do

  let(:query) do
    Origin::Query.new
  end

  describe "#where" do

    context "when provided no criterion" do

      let(:selection) do
        query.where
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
        query.where(nil)
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

    context "when provided a string" do

      let(:selection) do
        query.where("this.value = 10")
      end

      it "adds the $where criterion" do
        selection.selector.should eq({ "$where" => "this.value = 10" })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided a single criterion" do

    end

    context "when provided multiple criterion" do

    end

    context "when provided complex criterion" do

      context "when performing an $all" do

        let(:selection) do
          query.where(:field.all => [ 1, 2 ])
        end

        it "adds the $all criterion" do
          selection.selector.should eq({ :field => { "$all" => [ 1, 2 ] }})
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing an $elemMatch" do

        let(:selection) do
          query.where(:field.elem_match => { :key => 1 })
        end

        it "adds the $elemMatch criterion" do
          selection.selector.should eq(
            { :field => { "$elemMatch" => { :key => 1 } }}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing an $exists" do

        let(:selection) do
          query.where(:field.exists => true)
        end

        it "adds the $exists criterion" do
          selection.selector.should eq(
            { :field => { "$exists" => true }}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $gt" do

        let(:selection) do
          query.where(:field.gt => 10)
        end

        it "adds the $gt criterion" do
          selection.selector.should eq(
            { :field => { "$gt" => 10 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $gte" do

        let(:selection) do
          query.where(:field.gte => 10)
        end

        it "adds the $gte criterion" do
          selection.selector.should eq(
            { :field => { "$gte" => 10 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing an $in" do

        let(:selection) do
          query.where(:field.in => [ 1, 2 ])
        end

        it "adds the $in criterion" do
          selection.selector.should eq({ :field => { "$in" => [ 1, 2 ] }})
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $lt" do

        let(:selection) do
          query.where(:field.lt => 10)
        end

        it "adds the $lt criterion" do
          selection.selector.should eq(
            { :field => { "$lt" => 10 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $lte" do

        let(:selection) do
          query.where(:field.lte => 10)
        end

        it "adds the $lte criterion" do
          selection.selector.should eq(
            { :field => { "$lte" => 10 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $mod" do

        let(:selection) do
          query.where(:field.mod => [ 10, 1 ])
        end

        it "adds the $lte criterion" do
          selection.selector.should eq(
            { :field => { "$mod" => [ 10, 1 ]}}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $ne" do

        let(:selection) do
          query.where(:field.ne => 10)
        end

        it "adds the $ne criterion" do
          selection.selector.should eq(
            { :field => { "$ne" => 10 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $near" do

        let(:selection) do
          query.where(:field.near => [ 1, 1 ])
        end

        it "adds the $near criterion" do
          selection.selector.should eq(
            { :field => { "$near" => [ 1, 1 ] }}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $nearSphere" do

        let(:selection) do
          query.where(:field.near_sphere => [ 1, 1 ])
        end

        it "adds the $nearSphere criterion" do
          selection.selector.should eq(
            { :field => { "$nearSphere" => [ 1, 1 ] }}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $nin" do

        let(:selection) do
          query.where(:field.nin => [ 1, 2 ])
        end

        it "adds the $nin criterion" do
          selection.selector.should eq({ :field => { "$nin" => [ 1, 2 ] }})
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $size" do

        let(:selection) do
          query.where(:field.with_size => 10)
        end

        it "adds the $size criterion" do
          selection.selector.should eq(
            { :field => { "$size" => 10 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $type" do

        let(:selection) do
          query.where(:field.type => 10)
        end

        it "adds the $type criterion" do
          selection.selector.should eq(
            { :field => { "$type" => 10 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $within" do

        context "when within a circle" do

          let(:selection) do
            query.where(:field.within_circle => [[ 1, 1 ], 10 ])
          end

          it "adds the $within and $center criterion" do
            selection.selector.should eq(
              { :field => { "$within" => { "$center" => [[ 1, 1 ], 10 ]}}}
            )
          end

          it "returns a cloned query" do
            selection.should_not eq(query)
          end
        end

        context "when within a box" do

          let(:selection) do
            query.where(:field.within_box => [[ 1, 1 ], [ 1, 1 ]])
          end

          it "adds the $within and $box criterion" do
            selection.selector.should eq(
              { :field => { "$within" => { "$box" => [[ 1, 1 ], [ 1, 1 ]]}}}
            )
          end

          it "returns a cloned query" do
            selection.should_not eq(query)
          end
        end
      end
    end
  end
end
