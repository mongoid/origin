require "spec_helper"

describe Origin::Optional::OrderBy do

  let(:query) do
    Origin::Query.new
  end

  describe "#order_by" do

    context "when provided a hash" do

      let(:selection) do
        query.order_by(field_one: 1, field_two: -1)
      end

      it "adds the sorting criteria" do
        selection.options.should eq(
          { :sort => { field_one: 1, field_two: -1 }}
        )
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided an array" do

      context "when the array is multi-dimensional" do

        let(:selection) do
          query.order_by([[ :field_one, 1 ],[ :field_two, -1 ]])
        end

        it "adds the sorting criteria" do
          selection.options.should eq(
            { :sort => { field_one: 1, field_two: -1 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the array is selectable keys" do

        let(:selection) do
          query.order_by([ :field_one.asc, :field_two.desc ])
        end

        it "adds the sorting criteria" do
          selection.options.should eq(
            { :sort => { field_one: 1, field_two: -1 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when provided values" do

      context "when the values are arrays" do

        let(:selection) do
          query.order_by([ :field_one, 1 ],[ :field_two, -1 ])
        end

        it "adds the sorting criteria" do
          selection.options.should eq(
            { :sort => { field_one: 1, field_two: -1 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the values are selectable keys" do

        let(:selection) do
          query.order_by(:field_one.asc, :field_two.desc)
        end

        it "adds the sorting criteria" do
          selection.options.should eq(
            { :sort => { field_one: 1, field_two: -1 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when provided a string" do

      context "when the direction is lowercase" do

        context "when abbreviated" do

          let(:selection) do
            query.order_by("field_one asc, field_two desc")
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { :sort => { field_one: 1, field_two: -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when spelled out" do

          let(:selection) do
            query.order_by("field_one ascending, field_two descending")
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { :sort => { field_one: 1, field_two: -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end

      context "when the direction is uppercase" do

        context "when abbreviated" do

          let(:selection) do
            query.order_by("field_one ASC, field_two DESC")
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { :sort => { field_one: 1, field_two: -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when spelled out" do

          let(:selection) do
            query.order_by("field_one ASCENDING, field_two DESCENDING")
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { :sort => { field_one: 1, field_two: -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end
    end

    context "when provided no options" do

      let(:selection) do
        query.order_by
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
        query.order_by(nil)
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end
  end
end
