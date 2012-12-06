require "spec_helper"

describe Origin::Optional do

  let(:query) do
    Origin::Query.new
  end

  [ :asc, :ascending ].each do |method|

    describe "##{method}" do

      context "when using the moped driver syntax" do

        context "when provided symbols" do

          let(:selection) do
            query.send(method, :field_one, :field_two)
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => 1, "field_two" => 1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided an array of symbols" do

          let(:selection) do
            query.send(method, [ :field_one, :field_two ])
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => 1, "field_two" => 1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided strings" do

          let(:selection) do
            query.send(method, "field_one", "field_two")
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => 1, "field_two" => 1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided an array of strings" do

          let(:selection) do
            query.send(method, [ "field_one", "field_two" ])
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => 1, "field_two" => 1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided no options" do

          let(:selection) do
            query.send(method)
          end

          it "does not add any sorting criteria" do
            selection.options.should be_empty
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
            query.send(method, nil)
          end

          it "does not add any sorting criteria" do
            selection.options.should be_empty
          end

          it "returns the query" do
            selection.should eq(query)
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end

      context "when using the mongo driver syntax" do

        let(:query) do
          Origin::Query.new({}, {}, :mongo)
        end

        context "when provided symbols" do

          let(:selection) do
            query.send(method, :field_one, :field_two)
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ :field_one, 1 ], [ :field_two, 1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided an array of symbols" do

          let(:selection) do
            query.send(method, [ :field_one, :field_two ])
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ :field_one, 1 ], [ :field_two, 1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided strings" do

          let(:selection) do
            query.send(method, "field_one", "field_two")
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ "field_one", 1 ], [ "field_two", 1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided an array of strings" do

          let(:selection) do
            query.send(method, [ "field_one", "field_two" ])
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ "field_one", 1 ], [ "field_two", 1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided no options" do

          let(:selection) do
            query.send(method)
          end

          it "does not add any sorting criteria" do
            selection.options.should be_empty
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
            query.send(method, nil)
          end

          it "does not add any sorting criteria" do
            selection.options.should be_empty
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
  end

  describe "#batch_size" do

    context "when provided no options" do

      let(:selection) do
        query.batch_size
      end

      it "does not add any options" do
        selection.options.should eq({})
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
        query.batch_size(nil)
      end

      it "does not add any options" do
        selection.options.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided arguments" do

      let(:selection) do
        query.batch_size(500)
      end

      it "adds the field options" do
        selection.options.should eq({ batch_size: 500 })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end
  end

  [ :desc, :descending ].each do |method|

    describe "##{method}" do

      context "when using the moped driver syntax" do

        context "when provided symbols" do

          let(:selection) do
            query.send(method, :field_one, :field_two)
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => -1, "field_two" => -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided an array of symbols" do

          let(:selection) do
            query.send(method, [ :field_one, :field_two ])
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => -1, "field_two" => -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided strings" do

          let(:selection) do
            query.send(method, "field_one", "field_two")
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => -1, "field_two" => -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided an array of strings" do

          let(:selection) do
            query.send(method, [ "field_one", "field_two" ])
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => -1, "field_two" => -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided no options" do

          let(:selection) do
            query.send(method)
          end

          it "does not add any sorting criteria" do
            selection.options.should be_empty
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
            query.send(method, nil)
          end

          it "does not add any sorting criteria" do
            selection.options.should be_empty
          end

          it "returns the query" do
            selection.should eq(query)
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end

      context "when using the mongo driver syntax" do

        let(:query) do
          Origin::Query.new({}, {}, :mongo)
        end

        context "when provided symbols" do

          let(:selection) do
            query.send(method, :field_one, :field_two)
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ :field_one, -1 ], [ :field_two, -1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided an array of symbols" do

          let(:selection) do
            query.send(method, [ :field_one, :field_two ])
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ :field_one, -1 ], [ :field_two, -1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided strings" do

          let(:selection) do
            query.send(method, "field_one", "field_two")
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ "field_one", -1 ], [ "field_two", -1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided an array of strings" do

          let(:selection) do
            query.send(method, [ "field_one", "field_two" ])
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ "field_one", -1 ], [ "field_two", -1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided no options" do

          let(:selection) do
            query.send(method)
          end

          it "does not add any sorting criteria" do
            selection.options.should be_empty
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
            query.send(method, nil)
          end

          it "does not add any sorting criteria" do
            selection.options.should be_empty
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
  end

  describe "#hint" do

    context "when provided no options" do

      let(:selection) do
        query.hint
      end

      it "does not add any options" do
        selection.options.should eq({})
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
        query.hint(nil)
      end

      it "does not add any options" do
        selection.options.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided arguments" do

      context "when the argument is a hash" do

        let(:selection) do
          query.hint("$natural" => 1)
        end

        it "adds the field options" do
          selection.options.should eq({ hint: { "$natural" => 1 }})
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#limit" do

    context "when provided no options" do

      let(:selection) do
        query.limit
      end

      it "does not add any options" do
        selection.options.should eq({})
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
        query.limit(nil)
      end

      it "does not add any options" do
        selection.options.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided arguments" do

      context "when the argument is an integer" do

        let(:selection) do
          query.limit(10)
        end

        it "adds the field options" do
          selection.options.should eq({ limit: 10 })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the argument is a float" do

        let(:selection) do
          query.limit(10.25)
        end

        it "adds the field options as an integer" do
          selection.options.should eq({ limit: 10 })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the argument is a string" do

        let(:selection) do
          query.limit("10")
        end

        it "adds the field options as an integer" do
          selection.options.should eq({ limit: 10 })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#max_scan" do

    context "when provided no options" do

      let(:selection) do
        query.max_scan
      end

      it "does not add any options" do
        selection.options.should eq({})
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
        query.max_scan(nil)
      end

      it "does not add any options" do
        selection.options.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided arguments" do

      let(:selection) do
        query.max_scan(500)
      end

      it "adds the field options" do
        selection.options.should eq({ max_scan: 500 })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end
  end

  describe "#no_timeout" do

    let(:selection) do
      query.no_timeout
    end

    it "adds the timeout option" do
      selection.options.should eq({ timeout: false })
    end
  end

  describe "#only" do

    context "when provided no options" do

      let(:selection) do
        query.only
      end

      it "does not add any options" do
        selection.options.should eq({})
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
        query.only(nil)
      end

      it "does not add any options" do
        selection.options.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided fields" do

      context "as several arguments" do

        let(:selection) do
          query.only(:first, :second)
        end

        it "adds the field options" do
          selection.options.should eq(
            { fields: { "first" => 1, "second" => 1 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "as one argument - array" do

        let(:selection) do
          query.only([:first, :second])
        end

        it "adds the field options" do
          selection.options.should eq(
            { fields: { "first" => 1, "second" => 1 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when #without was called first" do

      let(:selection) do
        query.without(:id).only(:first)
      end

      it "adds both fields to option"  do
        selection.options.should eq(
          { fields: { "id" => 0, "first" => 1 } }
        )
      end
    end
  end

  describe "#order_by" do

    context "when using the moped driver syntax" do

      context "when provided a hash" do

        context "when the hash has integer values" do

          let(:selection) do
            query.order_by(field_one: 1, field_two: -1)
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => 1, "field_two" => -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the hash has symbol values" do

          let(:selection) do
            query.order_by(field_one: :asc, field_two: :desc)
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => 1, "field_two" => -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the hash has string values" do

          let(:selection) do
            query.order_by(field_one: "asc", field_two: "desc")
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => 1, "field_two" => -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end

      context "when provided an array" do

        context "when the array is multi-dimensional" do

          context "when the arrays have integer values" do

            let(:selection) do
              query.order_by([[ :field_one, 1 ],[ :field_two, -1 ]])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: { "field_one" => 1, "field_two" => -1 }}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the arrays have symbol values" do

            let(:selection) do
              query.order_by([[ :field_one, :asc ],[ :field_two, :desc ]])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: { "field_one" => 1, "field_two" => -1 }}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the arrays have string values" do

            let(:selection) do
              query.order_by([[ :field_one, "asc" ],[ :field_two, "desc" ]])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: { "field_one" => 1, "field_two" => -1 }}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end
        end

        context "when the array is selectable keys" do

          let(:selection) do
            query.order_by([ :field_one.asc, :field_two.desc ])
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => 1, "field_two" => -1 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end

      context "when provided values" do

        context "when the values are arrays" do

          context "when the values have integer directions" do

            let(:selection) do
              query.order_by([ :field_one, 1 ],[ :field_two, -1 ])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: { "field_one" => 1, "field_two" => -1 }}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the values have symbol directions" do

            let(:selection) do
              query.order_by([ :field_one, :asc ],[ :field_two, :desc ])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: { "field_one" => 1, "field_two" => -1 }}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the values have string directions" do

            let(:selection) do
              query.order_by([ :field_one, "asc" ],[ :field_two, "desc" ])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: { "field_one" => 1, "field_two" => -1 }}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end
        end

        context "when the values are selectable keys" do

          let(:selection) do
            query.order_by(:field_one.asc, :field_two.desc)
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: { "field_one" => 1, "field_two" => -1 }}
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
                { sort: { "field_one" => 1, "field_two" => -1 }}
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
                { sort: { "field_one" => 1, "field_two" => -1 }}
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
                { sort: { "field_one" => 1, "field_two" => -1 }}
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
                { sort: { "field_one" => 1, "field_two" => -1 }}
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

    context "when using the mongo driver syntax" do

      let(:query) do
        Origin::Query.new({}, {}, :mongo)
      end

      context "when provided a hash" do

        context "when the hash has integer values" do

          let(:selection) do
            query.order_by(field_one: 1, field_two: -1)
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the hash has symbol values" do

          let(:selection) do
            query.order_by(field_one: :asc, field_two: :desc)
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the hash has string values" do

          let(:selection) do
            query.order_by(field_one: "asc", field_two: "desc")
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end

      context "when provided an array" do

        context "when the array is multi-dimensional" do

          context "when the arrays have integer values" do

            let(:selection) do
              query.order_by([[ :field_one, 1 ],[ :field_two, -1 ]])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the arrays have symbol values" do

            let(:selection) do
              query.order_by([[ :field_one, :asc ],[ :field_two, :desc ]])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the arrays have string values" do

            let(:selection) do
              query.order_by([[ :field_one, "asc" ],[ :field_two, "desc" ]])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end
        end

        context "when the array is selectable keys" do

          let(:selection) do
            query.order_by([ :field_one.asc, :field_two.desc ])
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
            )
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end

      context "when provided values" do

        context "when the values are arrays" do

          context "when the values have integer directions" do

            let(:selection) do
              query.order_by([ :field_one, 1 ],[ :field_two, -1 ])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the values have symbol directions" do

            let(:selection) do
              query.order_by([ :field_one, :asc ],[ :field_two, :desc ])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the values have string directions" do

            let(:selection) do
              query.order_by([ :field_one, "asc" ],[ :field_two, "desc" ])
            end

            it "adds the sorting criteria" do
              selection.options.should eq(
                { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
              )
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end
        end

        context "when the values are selectable keys" do

          let(:selection) do
            query.order_by(:field_one.asc, :field_two.desc)
          end

          it "adds the sorting criteria" do
            selection.options.should eq(
              { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
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
                { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
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
                { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
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
                { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
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
                { sort: [[ :field_one, 1 ], [ :field_two, -1 ]]}
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

  [ :skip, :offset ].each do |method|

    describe "\##{method}" do

      context "when provided no options" do

        let(:selection) do
          query.send(method)
        end

        it "does not add any options" do
          selection.options.should eq({})
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
          query.send(method, nil)
        end

        it "does not add any options" do
          selection.options.should eq({})
        end

        it "returns the query" do
          selection.should eq(query)
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when provided arguments" do

        context "when provided an integer" do

          let(:selection) do
            query.send(method, 10)
          end

          it "adds the field options" do
            selection.options.should eq({ skip: 10 })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided a float" do

          let(:selection) do
            query.send(method, 10.25)
          end

          it "adds the field options converted to an integer" do
            selection.options.should eq({ skip: 10 })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided a non number" do

          let(:selection) do
            query.send(method, "10")
          end

          it "adds the field options converted to an integer" do
            selection.options.should eq({ skip: 10 })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end
    end
  end

  describe "#slice" do

    context "when provided no options" do

      let(:selection) do
        query.slice
      end

      it "does not add any options" do
        selection.options.should eq({})
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
        query.slice(nil)
      end

      it "does not add any options" do
        selection.options.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided a single argument" do

      let(:selection) do
        query.slice(:first => 5)
      end

      it "adds the field options" do
        selection.options.should eq(
          { fields: { "first" => { "$slice" => 5 }}}
        )
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided a multiple arguments" do

      let(:selection) do
        query.slice(:first => 5, :second => [ 0, 3 ])
      end

      it "adds the field options" do
        selection.options.should eq({ fields:
          { "first" => { "$slice" => 5 }, "second" => { "$slice" => [ 0, 3 ] }}
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when existing field arguments exist" do

      let(:limited) do
        query.only(:name)
      end

      let(:selection) do
        limited.slice(:first => 5, :second => [ 0, 3 ])
      end

      it "adds the field options" do
        selection.options.should eq({
          fields: {
            "name" => 1,
            "first" => { "$slice" => 5 },
            "second" => { "$slice" => [ 0, 3 ] }
          }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end
  end

  describe "#snapshot" do

    let(:selection) do
      query.snapshot
    end

    it "adds the snapshot option" do
      selection.options.should eq({ snapshot: true })
    end
  end

  describe "#without" do

    context "when provided no options" do

      let(:selection) do
        query.without
      end

      it "does not add any options" do
        selection.options.should eq({})
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
        query.without(nil)
      end

      it "does not add any options" do
        selection.options.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided fields" do

      context "as sevaral arguments" do

        let(:selection) do
          query.without(:first, :second)
        end

        it "adds the field options" do
          selection.options.should eq(
            { fields: { "first" => 0, "second" => 0 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "as one argument - array" do

        let(:selection) do
          query.without([:first, :second])
        end

        it "adds the field options" do
          selection.options.should eq(
            { fields: { "first" => 0, "second" => 0 }}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when #only was called before" do
      let(:selection) do
        query.only(:first).without(:id)
      end

      it "adds both fields to options" do
        selection.options.should eq(
          { fields: { "first" => 1, "id" => 0 } }
        )
      end
    end
  end
end
