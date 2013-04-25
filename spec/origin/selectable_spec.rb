require "spec_helper"

describe Origin::Selectable do

  let(:query) do
    Origin::Query.new("id" => "_id")
  end

  describe "#all" do

    context "when provided no criterion" do

      let(:selection) do
        query.all
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
        query.all(nil)
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

    context "when provided a single criterion" do

      context "when no serializers are provided" do

        context "when providing an array" do

          let(:selection) do
            query.all(field: [ 1, 2 ])
          end

          it "adds the $all selector" do
            selection.selector.should eq({
              "field" => { "$all" => [ 1, 2 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when providing a range" do

          let(:selection) do
            query.all(field: 1..3)
          end

          it "adds the $all selector with converted range" do
            selection.selector.should eq({
              "field" => { "$all" => [ 1, 2, 3 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when providing a single value" do

          let(:selection) do
            query.all(field: 1)
          end

          it "adds the $all selector with wrapped value" do
            selection.selector.should eq({
              "field" => { "$all" => [ 1 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end

      context "when serializers are provided" do

        before(:all) do
          class Field
            def evolve(object)
              Integer.evolve(object)
            end
            def localized?
              false
            end
          end
        end

        after(:all) do
          Object.send(:remove_const, :Field)
        end

        let!(:query) do
          Origin::Query.new({}, { "field" => Field.new })
        end

        context "when providing an array" do

          let(:selection) do
            query.all(field: [ "1", "2" ])
          end

          it "adds the $all selector" do
            selection.selector.should eq({
              "field" => { "$all" => [ 1, 2 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when providing a range" do

          let(:selection) do
            query.all(field: "1".."3")
          end

          it "adds the $all selector with converted range" do
            selection.selector.should eq({
              "field" => { "$all" => [ 1, 2, 3 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when providing a single value" do

          let(:selection) do
            query.all(field: "1")
          end

          it "adds the $all selector with wrapped value" do
            selection.selector.should eq({
              "field" => { "$all" => [ 1 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.all(first: [ 1, 2 ], second: [ 3, 4 ])
        end

        it "adds the $all selectors" do
          selection.selector.should eq({
            "first" => { "$all" => [ 1, 2 ] },
            "second" => { "$all" => [ 3, 4 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.all(first: [ 1, 2 ]).all(second: [ 3, 4 ])
        end

        it "adds the $all selectors" do
          selection.selector.should eq({
            "first" => { "$all" => [ 1, 2 ] },
            "second" => { "$all" => [ 3, 4 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        context "when no serializers are provided" do

          context "when the strategy is the default (union)" do

            let(:selection) do
              query.all(first: [ 1, 2 ]).all(first: [ 3, 4 ])
            end

            it "overwrites the first $all selector" do
              selection.selector.should eq({
                "first" => { "$all" => [ 1, 2, 3, 4 ] }
              })
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the strategy is intersect" do

            let(:selection) do
              query.all(first: [ 1, 2 ]).intersect.all(first: [ 2, 3 ])
            end

            it "intersects the $all selectors" do
              selection.selector.should eq({
                "first" => { "$all" => [ 2 ] }
              })
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the strategy is override" do

            let(:selection) do
              query.all(first: [ 1, 2 ]).override.all(first: [ 3, 4 ])
            end

            it "overwrites the first $all selector" do
              selection.selector.should eq({
                "first" => { "$all" => [ 3, 4 ] }
              })
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the strategy is union" do

            let(:selection) do
              query.all(first: [ 1, 2 ]).union.all(first: [ 3, 4 ])
            end

            it "unions the $all selectors" do
              selection.selector.should eq({
                "first" => { "$all" => [ 1, 2, 3, 4 ] }
              })
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end
        end

        context "when serializers are provided" do

          before(:all) do
            class Field
              def evolve(object)
                Integer.evolve(object)
              end
              def localized?
                false
              end
            end
          end

          after(:all) do
            Object.send(:remove_const, :Field)
          end

          let!(:query) do
            Origin::Query.new({}, { "field" => Field.new })
          end

          context "when the strategy is the default (union)" do

            let(:selection) do
              query.all(field: [ "1", "2" ]).all(field: [ "3", "4" ])
            end

            it "overwrites the field $all selector" do
              selection.selector.should eq({
                "field" => { "$all" => [ 1, 2, 3, 4 ] }
              })
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the strategy is intersect" do

            let(:selection) do
              query.all(field: [ "1", "2" ]).intersect.all(field: [ "2", "3" ])
            end

            it "intersects the $all selectors" do
              selection.selector.should eq({
                "field" => { "$all" => [ 2 ] }
              })
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the strategy is override" do

            let(:selection) do
              query.all(field: [ "1", "2" ]).override.all(field: [ "3", "4" ])
            end

            it "overwrites the field $all selector" do
              selection.selector.should eq({
                "field" => { "$all" => [ 3, 4 ] }
              })
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end

          context "when the strategy is union" do

            let(:selection) do
              query.all(field: [ "1", "2" ]).union.all(field: [ "3", "4" ])
            end

            it "unions the $all selectors" do
              selection.selector.should eq({
                "field" => { "$all" => [ 1, 2, 3, 4 ] }
              })
            end

            it "returns a cloned query" do
              selection.should_not equal(query)
            end
          end
        end
      end
    end
  end

  describe "#and" do

    context "when provided no criterion" do

      let(:selection) do
        query.and
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
        query.and(nil)
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

    context "when provided a single criterion" do

      let(:selection) do
        query.and(field: [ 1, 2 ])
      end

      it "adds the $and selector" do
        selection.selector.should eq({
          "$and" => [{ "field" => [ 1, 2 ] }]
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided a nested criterion" do

      let(:selection) do
        query.and(:test.elem_match => { :field.in => [ 1, 2 ] })
      end

      it "adds the $and selector" do
        selection.selector.should eq({
          "$and" => [{ "test" => { "$elemMatch" => { "field" => { "$in" => [ 1, 2 ] }}}}]
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion is already included" do

        let(:selection) do
          query.and({ first: [ 1, 2 ] }).and({ first: [ 1, 2 ] })
        end

        it "does not duplicate the $and selector" do
          selection.selector.should eq({
            "$and" => [
              { "first" => [ 1, 2 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are for different fields" do

        let(:selection) do
          query.and({ first: [ 1, 2 ] }, { second: [ 3, 4 ] })
        end

        it "adds the $and selector" do
          selection.selector.should eq({
            "$and" => [
              { "first" => [ 1, 2 ] },
              { "second" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.and({ first: [ 1, 2 ] }, { first: [ 3, 4 ] })
        end

        it "appends both $and expressions" do
          selection.selector.should eq({
            "$and" => [
              { "first" => [ 1, 2 ] },
              { "first" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.and(first: [ 1, 2 ]).and(second: [ 3, 4 ])
        end

        it "adds the $and selectors" do
          selection.selector.should eq({
            "$and" => [
              { "first" => [ 1, 2 ] },
              { "second" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.and(first: [ 1, 2 ]).and(first: [ 3, 4 ])
        end

        it "appends both $and expressions" do
          selection.selector.should eq({
            "$and" => [
              { "first" => [ 1, 2 ] },
              { "first" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#between" do

    context "when provided no criterion" do

      let(:selection) do
        query.between
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
        query.between(nil)
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

    context "when provided a single range" do

      let(:selection) do
        query.between(field: 1..10)
      end

      it "adds the $gte and $lte selectors" do
        selection.selector.should eq({
          "field" => { "$gte" => 1, "$lte" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple ranges" do

      context "when the ranges are on different fields" do

        let(:selection) do
          query.between(field: 1..10, key: 5..7)
        end

        it "adds the $gte and $lte selectors" do
          selection.selector.should eq({
            "field" => { "$gte" => 1, "$lte" => 10 },
            "key" => { "$gte" => 5, "$lte" => 7 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#elem_match" do

    context "when provided no criterion" do

      let(:selection) do
        query.elem_match
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
        query.elem_match(nil)
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

      context "when there are no nested complex keys" do

        let(:selection) do
          query.elem_match(users: { name: "value" })
        end

        it "adds the $elemMatch expression" do
          selection.selector.should eq({
            "users" => { "$elemMatch" => { name: "value" }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when there are nested complex keys" do

        let(:time) do
          Time.now
        end

        let(:selection) do
          query.elem_match(users: { :time.gt => time })
        end

        it "adds the $elemMatch expression" do
          selection.selector.should eq({
            "users" => { "$elemMatch" => { "time" => { "$gt" => time }}}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.elem_match(
            users: { name: "value" },
            comments: { text: "value" }
          )
        end

        it "adds the $elemMatch expression" do
          selection.selector.should eq({
            "users" => { "$elemMatch" => { name: "value" }},
            "comments" => { "$elemMatch" => { text: "value" }}
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
            elem_match(users: { name: "value" }).
            elem_match(comments: { text: "value" })
        end

        it "adds the $elemMatch expression" do
          selection.selector.should eq({
            "users" => { "$elemMatch" => { name: "value" }},
            "comments" => { "$elemMatch" => { text: "value" }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the fields are the same" do

        let(:selection) do
          query.
            elem_match(users: { name: "value" }).
            elem_match(users: { state: "new" })
        end

        it "overrides the $elemMatch expression" do
          selection.selector.should eq({
            "users" => { "$elemMatch" => { state: "new" }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#exists" do

    context "when provided no criterion" do

      let(:selection) do
        query.exists
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
        query.exists(nil)
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

      context "when provided a boolean" do

        let(:selection) do
          query.exists(users: true)
        end

        it "adds the $exists expression" do
          selection.selector.should eq({
            "users" => { "$exists" => true }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when provided a string" do

        let(:selection) do
          query.exists(users: "yes")
        end

        it "adds the $exists expression" do
          selection.selector.should eq({
            "users" => { "$exists" => true }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        context "when providing boolean values" do

          let(:selection) do
            query.exists(
              users: true,
              comments: true
            )
          end

          it "adds the $exists expression" do
            selection.selector.should eq({
              "users" => { "$exists" => true },
              "comments" => { "$exists" => true }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when providing string values" do

          let(:selection) do
            query.exists(
              users: "y",
              comments: "true"
            )
          end

          it "adds the $exists expression" do
            selection.selector.should eq({
              "users" => { "$exists" => true },
              "comments" => { "$exists" => true }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end
    end

    context "when chaining multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.
            exists(users: true).
            exists(comments: true)
        end

        it "adds the $exists expression" do
          selection.selector.should eq({
            "users" => { "$exists" => true },
            "comments" => { "$exists" => true }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#gt" do

    context "when provided no criterion" do

      let(:selection) do
        query.gt
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
        query.gt(nil)
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

    context "when provided a single criterion" do

      let(:selection) do
        query.gt(field: 10)
      end

      it "adds the $gt selector" do
        selection.selector.should eq({
          "field" => { "$gt" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.gt(first: 10, second: 15)
        end

        it "adds the $gt selectors" do
          selection.selector.should eq({
            "first" => { "$gt" => 10 },
            "second" => { "$gt" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.gt(first: 10).gt(second: 15)
        end

        it "adds the $gt selectors" do
          selection.selector.should eq({
            "first" => { "$gt" => 10 },
            "second" => { "$gt" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.gt(first: 10).gt(first: 15)
        end

        it "overwrites the first $gt selector" do
          selection.selector.should eq({
            "first" => { "$gt" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#gte" do

    context "when provided no criterion" do

      let(:selection) do
        query.gte
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
        query.gte(nil)
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

    context "when provided a single criterion" do

      let(:selection) do
        query.gte(field: 10)
      end

      it "adds the $gte selector" do
        selection.selector.should eq({
          "field" => { "$gte" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.gte(first: 10, second: 15)
        end

        it "adds the $gte selectors" do
          selection.selector.should eq({
            "first" => { "$gte" => 10 },
            "second" => { "$gte" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.gte(first: 10).gte(second: 15)
        end

        it "adds the $gte selectors" do
          selection.selector.should eq({
            "first" => { "$gte" => 10 },
            "second" => { "$gte" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.gte(first: 10).gte(first: 15)
        end

        it "overwrites the first $gte selector" do
          selection.selector.should eq({
            "first" =>  { "$gte" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#in" do

    context "when provided no criterion" do

      let(:selection) do
        query.in
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
        query.in(nil)
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

    context "when provided a single criterion" do

      context "when providing an array" do

        let(:selection) do
          query.in(field: [ 1, 2 ])
        end

        it "adds the $in selector" do
          selection.selector.should eq({
            "field" =>  { "$in" => [ 1, 2 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when providing a range" do

        let(:selection) do
          query.in(field: 1..3)
        end

        it "adds the $in selector with converted range" do
          selection.selector.should eq({
            "field" =>  { "$in" => [ 1, 2, 3 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when providing a single value" do

        let(:selection) do
          query.in(field: 1)
        end

        it "adds the $in selector with wrapped value" do
          selection.selector.should eq({
            "field" =>  { "$in" => [ 1 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.in(first: [ 1, 2 ], second: 3..4)
        end

        it "adds the $in selectors" do
          selection.selector.should eq({
            "first" =>  { "$in" => [ 1, 2 ] },
            "second" =>  { "$in" => [ 3, 4 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.in(first: [ 1, 2 ]).in(second: [ 3, 4 ])
        end

        it "adds the $in selectors" do
          selection.selector.should eq({
            "first" =>  { "$in" => [ 1, 2 ] },
            "second" =>  { "$in" => [ 3, 4 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        context "when the stretegy is the default (intersection)" do

          let(:selection) do
            query.in(first: [ 1, 2 ].freeze).in(first: [ 2, 3 ])
          end

          it "intersects the $in selectors" do
            selection.selector.should eq({
              "first" =>  { "$in" => [ 2 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is intersect" do

          let(:selection) do
            query.in(first: [ 1, 2 ]).intersect.in(first: [ 2, 3 ])
          end

          it "intersects the $in selectors" do
            selection.selector.should eq({
              "first" =>  { "$in" => [ 2 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is override" do

          let(:selection) do
            query.in(first: [ 1, 2 ]).override.in(first: [ 3, 4 ])
          end

          it "overwrites the first $in selector" do
            selection.selector.should eq({
              "first" =>  { "$in" => [ 3, 4 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is union" do

          let(:selection) do
            query.in(first: [ 1, 2 ]).union.in(first: [ 3, 4 ])
          end

          it "unions the $in selectors" do
            selection.selector.should eq({
              "first" =>  { "$in" => [ 1, 2, 3, 4 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end
    end
  end

  describe "#lt" do

    context "when provided no criterion" do

      let(:selection) do
        query.lt
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
        query.lt(nil)
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

    context "when provided a single criterion" do

      let(:selection) do
        query.lt(field: 10)
      end

      it "adds the $lt selector" do
        selection.selector.should eq({
          "field" =>  { "$lt" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.lt(first: 10, second: 15)
        end

        it "adds the $lt selectors" do
          selection.selector.should eq({
            "first" =>  { "$lt" => 10 },
            "second" =>  { "$lt" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.lt(first: 10).lt(second: 15)
        end

        it "adds the $lt selectors" do
          selection.selector.should eq({
            "first" =>  { "$lt" => 10 },
            "second" =>  { "$lt" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.lt(first: 10).lt(first: 15)
        end

        it "overwrites the first $lt selector" do
          selection.selector.should eq({
            "first" =>  { "$lt" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#lte" do

    context "when provided no criterion" do

      let(:selection) do
        query.lte
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
        query.lte(nil)
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

    context "when provided a single criterion" do

      let(:selection) do
        query.lte(field: 10)
      end

      it "adds the $lte selector" do
        selection.selector.should eq({
          "field" =>  { "$lte" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.lte(first: 10, second: 15)
        end

        it "adds the $lte selectors" do
          selection.selector.should eq({
            "first" =>  { "$lte" => 10 },
            "second" =>  { "$lte" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.lte(first: 10).lte(second: 15)
        end

        it "adds the $lte selectors" do
          selection.selector.should eq({
            "first" =>  { "$lte" => 10 },
            "second" =>  { "$lte" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.lte(first: 10).lte(first: 15)
        end

        it "overwrites the first $lte selector" do
          selection.selector.should eq({
            "first" =>  { "$lte" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#max_distance" do

    context "when provided no criterion" do

      let(:selection) do
        query.max_distance
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
        query.max_distance(nil)
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

      context "when a $near criterion exists on the same field" do

        let(:selection) do
          query.near(location: [ 1, 1 ]).max_distance(location: 50)
        end

        it "adds the $maxDistance expression" do
          selection.selector.should eq({
            "location" =>  { "$near" => [ 1, 1 ], "$maxDistance" => 50 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#mod" do

    context "when provided no criterion" do

      let(:selection) do
        query.mod
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
        query.mod(nil)
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
        query.mod(value: [ 10, 1 ])
      end

      it "adds the $mod expression" do
        selection.selector.should eq({
          "value" =>  { "$mod" => [ 10, 1 ] }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.mod(
            value: [ 10, 1 ],
            comments: [ 10, 1 ]
          )
        end

        it "adds the $mod expression" do
          selection.selector.should eq({
            "value" =>  { "$mod" => [ 10, 1 ] },
            "comments" =>  { "$mod" => [ 10, 1 ] }
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
            mod(value: [ 10, 1 ]).
            mod(result: [ 10, 1 ])
        end

        it "adds the $mod expression" do
          selection.selector.should eq({
            "value" =>  { "$mod" => [ 10, 1 ] },
            "result" =>  { "$mod" => [ 10, 1 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#ne" do

    context "when provided no criterion" do

      let(:selection) do
        query.ne
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
        query.ne(nil)
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
        query.ne(value: 10)
      end

      it "adds the $ne expression" do
        selection.selector.should eq({
          "value" =>  { "$ne" => 10 }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.ne(
            value: 10,
            comments: 10
          )
        end

        it "adds the $ne expression" do
          selection.selector.should eq({
            "value" =>  { "$ne" => 10 },
            "comments" =>  { "$ne" => 10 }
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
            ne(value: 10).
            ne(result: 10)
        end

        it "adds the $ne expression" do
          selection.selector.should eq({
            "value" =>  { "$ne" => 10 },
            "result" =>  { "$ne" => 10 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#near" do

    context "when provided no criterion" do

      let(:selection) do
        query.near
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
        query.near(nil)
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
        query.near(location: [ 20, 21 ])
      end

      it "adds the $near expression" do
        selection.selector.should eq({
          "location" =>  { "$near" => [ 20, 21 ] }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.near(
            location: [ 20, 21 ],
            comments: [ 20, 21 ]
          )
        end

        it "adds the $near expression" do
          selection.selector.should eq({
            "location" =>  { "$near" => [ 20, 21 ] },
            "comments" =>  { "$near" => [ 20, 21 ] }
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
            near(location: [ 20, 21 ]).
            near(comments: [ 20, 21 ])
        end

        it "adds the $near expression" do
          selection.selector.should eq({
            "location" =>  { "$near" => [ 20, 21 ] },
            "comments" =>  { "$near" => [ 20, 21 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
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

      context "when providing an array" do

        let(:selection) do
          query.nin(field: [ 1, 2 ])
        end

        it "adds the $nin selector" do
          selection.selector.should eq({
            "field" =>  { "$nin" => [ 1, 2 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when providing a range" do

        let(:selection) do
          query.nin(field: 1..3)
        end

        it "adds the $nin selector with converted range" do
          selection.selector.should eq({
            "field" =>  { "$nin" => [ 1, 2, 3 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when providing a single value" do

        let(:selection) do
          query.nin(field: 1)
        end

        it "adds the $nin selector with wrapped value" do
          selection.selector.should eq({
            "field" =>  { "$nin" => [ 1 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.nin(first: [ 1, 2 ], second: [ 3, 4 ])
        end

        it "adds the $nin selectors" do
          selection.selector.should eq({
            "first" =>  { "$nin" => [ 1, 2 ] },
            "second" =>  { "$nin" => [ 3, 4 ] }
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
          query.nin(first: [ 1, 2 ]).nin(second: [ 3, 4 ])
        end

        it "adds the $nin selectors" do
          selection.selector.should eq({
            "first" => { "$nin" => [ 1, 2 ] },
            "second" => { "$nin" => [ 3, 4 ] }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        context "when the stretegy is the default (intersection)" do

          let(:selection) do
            query.nin(first: [ 1, 2 ]).nin(first: [ 2, 3 ])
          end

          it "intersects the $nin selectors" do
            selection.selector.should eq({
              "first" => { "$nin" => [ 2 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is intersect" do

          let(:selection) do
            query.nin(first: [ 1, 2 ]).intersect.nin(first: [ 2, 3 ])
          end

          it "intersects the $nin selectors" do
            selection.selector.should eq({
              "first" => { "$nin" => [ 2 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is override" do

          let(:selection) do
            query.nin(first: [ 1, 2 ]).override.nin(first: [ 3, 4 ])
          end

          it "overwrites the first $nin selector" do
            selection.selector.should eq({
              "first" => { "$nin" => [ 3, 4 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when the stretegy is union" do

          let(:selection) do
            query.nin(first: [ 1, 2 ]).union.nin(first: [ 3, 4 ])
          end

          it "unions the $nin selectors" do
            selection.selector.should eq({
              "first" => { "$nin" => [ 1, 2, 3, 4 ] }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end
    end
  end

  describe "#nor" do

    context "when provided no criterion" do

      let(:selection) do
        query.nor
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
        query.nor(nil)
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

    context "when provided a single criterion" do

      let(:selection) do
        query.nor(field: [ 1, 2 ])
      end

      it "adds the $nor selector" do
        selection.selector.should eq({
          "$nor" => [{ field: [ 1, 2 ] }]
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are fnor different fields" do

        let(:selection) do
          query.nor({ first: [ 1, 2 ] }, { second: [ 3, 4 ] })
        end

        it "adds the $nor selector" do
          selection.selector.should eq({
            "$nor" => [
              { first: [ 1, 2 ] },
              { second: [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.nor({ first: [ 1, 2 ] }, { first: [ 3, 4 ] })
        end

        it "appends both $nor expressions" do
          selection.selector.should eq({
            "$nor" => [
              { first: [ 1, 2 ] },
              { first: [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are fnor different fields" do

        let(:selection) do
          query.nor(first: [ 1, 2 ]).nor(second: [ 3, 4 ])
        end

        it "adds the $nor selectors" do
          selection.selector.should eq({
            "$nor" => [
              { first: [ 1, 2 ] },
              { second: [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.nor(first: [ 1, 2 ]).nor(first: [ 3, 4 ])
        end

        it "appends both $nor expressions" do
          selection.selector.should eq({
            "$nor" => [
              { first: [ 1, 2 ] },
              { first: [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#not" do
    context "when provided no criterion" do

      let(:selection) do
        query.not
      end

      it "does not add any criterion" do
        selection.selector.should eq({})
      end

      it "returns the query" do
        selection.should eq(query)
      end

      it "returns a non cloned query" do
        selection.should equal(query)
      end

      context "when the following criteria is a query method" do

        let(:selection) do
          query.not.all(field: [ 1, 2 ])
        end

        it "negates the all selection" do
          selection.selector.should eq(
            { "field" => { "$not" => { "$all" => [ 1, 2 ] }}}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end

        it "removes the negation on the clone" do
          selection.should_not be_negating
        end
      end

      context "when the following criteria is a where" do

        let(:selection) do
          query.not.where(field: 1, :other.in => [ 1, 2 ])
        end

        it "negates the selection with an operator" do
          selection.selector.should eq(
            { "field" => 1, "other" => { "$not" => { "$in" => [ 1, 2 ] }}}
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end

        it "removes the negation on the clone" do
          selection.should_not be_negating
        end
      end

      context "when the following criteria is a where with a regexp" do

        let(:selection) do
          query.not.where(field: 1, other: /test/)
        end

        it "negates the selection with an operator" do
          selection.selector.should eq(
            { "field" => 1, "other" => { "$not" => /test/ } }
          )
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end

        it "removes the negation on the clone" do
          selection.should_not be_negating
        end

      end
    end

    context "when provided nil" do

      let(:selection) do
        query.not(nil)
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

    context "when provided a single criterion" do

      let(:selection) do
        query.not(field: /test/)
      end

      it "adds the $not selector" do
        selection.selector.should eq({
          "field" => { "$not" => /test/ }
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.not(first: /1/, second: /2/)
        end

        it "adds the $not selectors" do
          selection.selector.should eq({
            "first" => { "$not" => /1/ },
            "second" => { "$not" => /2/ }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.not(first: /1/).not(second: /2/)
        end

        it "adds the $not selectors" do
          selection.selector.should eq({
            "first" => { "$not" => /1/ },
            "second" => { "$not" => /2/ }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.not(first: /1/).not(first: /2/)
        end

        it "overwrites the first $not selector" do
          selection.selector.should eq({
            "first" =>  { "$not" => /2/ }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are a double negative" do

        let(:selection) do
          query.not.where(:first.not => /1/)
        end

        it "does not double the $not selector" do
          selection.selector.should eq({
            "first" =>  { "$not" => /1/ }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#or" do

    context "when provided no criterion" do

      let(:selection) do
        query.or
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
        query.or(nil)
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

    context "when provided a single criterion" do

      let(:selection) do
        query.or(field: [ 1, 2 ])
      end

      it "adds the $or selector" do
        selection.selector.should eq({
          "$or" => [{ "field" => [ 1, 2 ] }]
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.or({ first: [ 1, 2 ] }, { second: [ 3, 4 ] })
        end

        it "adds the $or selector" do
          selection.selector.should eq({
            "$or" => [
              { "first" => [ 1, 2 ] },
              { "second" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when a criterion has a selectable key" do

        let(:selection) do
          query.or({ first: [ 1, 2 ] }, { :second.gt => 3 })
        end

        it "adds the $or selector" do
          selection.selector.should eq({
            "$or" => [
              { "first" => [ 1, 2 ] },
              { "second" => { "$gt" => 3 }}
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion has an aliased field" do

        let(:selection) do
          query.or({ id: 1 })
        end

        it "adds the $or selector and aliases the field" do
          selection.selector.should eq({
            "$or" => [ { "_id" => 1 } ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when a criterion is wrapped in an array" do

        let(:selection) do
          query.or([{ first: [ 1, 2 ] }, { :second.gt => 3 }])
        end

        it "adds the $or selector" do
          selection.selector.should eq({
            "$or" => [
              { "first" => [ 1, 2 ] },
              { "second" => { "$gt" => 3 }}
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.or({ first: [ 1, 2 ] }, { first: [ 3, 4 ] })
        end

        it "appends both $or expressions" do
          selection.selector.should eq({
            "$or" => [
              { "first" => [ 1, 2 ] },
              { "first" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.or(first: [ 1, 2 ]).or(second: [ 3, 4 ])
        end

        it "adds the $or selectors" do
          selection.selector.should eq({
            "$or" => [
              { "first" => [ 1, 2 ] },
              { "second" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.or(first: [ 1, 2 ]).or(first: [ 3, 4 ])
        end

        it "appends both $or expressions" do
          selection.selector.should eq({
            "$or" => [
              { "first" => [ 1, 2 ] },
              { "first" => [ 3, 4 ] }
            ]
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#with_size" do

    context "when provided no criterion" do

      let(:selection) do
        query.with_size
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
        query.with_size(nil)
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

    context "when provided a single criterion" do

      context "when provided an integer" do

        let(:selection) do
          query.with_size(field: 10)
        end

        it "adds the $size selector" do
          selection.selector.should eq({
            "field" => { "$size" => 10 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when provided a string" do

        let(:selection) do
          query.with_size(field: "10")
        end

        it "adds the $size selector with an integer" do
          selection.selector.should eq({
            "field" => { "$size" => 10 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        context "when provided integers" do

          let(:selection) do
            query.with_size(first: 10, second: 15)
          end

          it "adds the $size selectors" do
            selection.selector.should eq({
              "first" => { "$size" => 10 },
              "second" => { "$size" => 15 }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end

        context "when provided strings" do

          let(:selection) do
            query.with_size(first: "10", second: "15")
          end

          it "adds the $size selectors" do
            selection.selector.should eq({
              "first" => { "$size" => 10 },
              "second" => { "$size" => 15 }
            })
          end

          it "returns a cloned query" do
            selection.should_not equal(query)
          end
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.with_size(first: 10).with_size(second: 15)
        end

        it "adds the $size selectors" do
          selection.selector.should eq({
            "first" => { "$size" => 10 },
            "second" => { "$size" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.with_size(first: 10).with_size(first: 15)
        end

        it "overwrites the first $size selector" do
          selection.selector.should eq({
            "first" => { "$size" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#type" do

    context "when provided no criterion" do

      let(:selection) do
        query.with_type
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
        query.with_type(nil)
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

    context "when provided a single criterion" do

      context "when provided an integer" do

        let(:selection) do
          query.with_type(field: 10)
        end

        it "adds the $type selector" do
          selection.selector.should eq({
            "field" => { "$type" => 10 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when provided a string" do

        let(:selection) do
          query.with_type(field: "10")
        end

        it "adds the $type selector" do
          selection.selector.should eq({
            "field" => { "$type" => 10 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when provided multiple criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.with_type(first: 10, second: 15)
        end

        it "adds the $type selectors" do
          selection.selector.should eq({
            "first" => { "$type" => 10 },
            "second" => { "$type" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining the criterion" do

      context "when the criterion are for different fields" do

        let(:selection) do
          query.with_type(first: 10).with_type(second: 15)
        end

        it "adds the $type selectors" do
          selection.selector.should eq({
            "first" => { "$type" => 10 },
            "second" => { "$type" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end

      context "when the criterion are on the same field" do

        let(:selection) do
          query.with_type(first: 10).with_type(first: 15)
        end

        it "overwrites the first $type selector" do
          selection.selector.should eq({
            "first" => { "$type" => 15 }
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
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

      context "when the value needs no evolution" do

        let(:selection) do
          query.where(name: "Syd")
        end

        it "adds the criterion to the selection" do
          selection.selector.should eq({ "name" => "Syd" })
        end
      end

      context "when the value must be evolved" do

        before(:all) do
          class Document
            def id
              13
            end
            def self.evolve(object)
              object.id
            end
          end
        end

        after(:all) do
          Object.send(:remove_const, :Document)
        end

        context "when the key needs evolution" do

          let(:query) do
            Origin::Query.new({ "user" => "user_id" })
          end

          let(:document) do
            Document.new
          end

          let(:selection) do
            query.where(user: document)
          end

          it "alters the key and value" do
            selection.selector.should eq({ "user_id" => document.id })
          end
        end
      end
    end

    context "when provided complex criterion" do

      context "when performing an $all" do

        context "when performing a single query" do

          let(:selection) do
            query.where(:field.all => [ 1, 2 ])
          end

          it "adds the $all criterion" do
            selection.selector.should eq({ "field" => { "$all" => [ 1, 2 ] }})
          end

          it "returns a cloned query" do
            selection.should_not eq(query)
          end
        end
      end

      context "when performing an $elemMatch" do

        context "when the value is not complex" do

          let(:selection) do
            query.where(:field.elem_match => { key: 1 })
          end

          it "adds the $elemMatch criterion" do
            selection.selector.should eq(
              { "field" => { "$elemMatch" => { key: 1 } }}
            )
          end

          it "returns a cloned query" do
            selection.should_not eq(query)
          end
        end

        context "when the value is complex" do

          let(:selection) do
            query.where(:field.elem_match => { :key.gt => 1 })
          end

          it "adds the $elemMatch criterion" do
            selection.selector.should eq(
              { "field" => { "$elemMatch" => { "key" => { "$gt" => 1 }}}}
            )
          end

          it "returns a cloned query" do
            selection.should_not eq(query)
          end
        end
      end

      context "when performing an $exists" do

        context "when providing boolean values" do

          let(:selection) do
            query.where(:field.exists => true)
          end

          it "adds the $exists criterion" do
            selection.selector.should eq(
              { "field" => { "$exists" => true }}
            )
          end

          it "returns a cloned query" do
            selection.should_not eq(query)
          end
        end

        context "when providing string values" do

          let(:selection) do
            query.where(:field.exists => "t")
          end

          it "adds the $exists criterion" do
            selection.selector.should eq(
              { "field" => { "$exists" => true }}
            )
          end

          it "returns a cloned query" do
            selection.should_not eq(query)
          end
        end
      end

      context "when performing a $gt" do

        let(:selection) do
          query.where(:field.gt => 10)
        end

        it "adds the $gt criterion" do
          selection.selector.should eq(
            { "field" => { "$gt" => 10 }}
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
            { "field" => { "$gte" => 10 }}
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
          selection.selector.should eq({ "field" => { "$in" => [ 1, 2 ] }})
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
            { "field" => { "$lt" => 10 }}
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
            { "field" => { "$lte" => 10 }}
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
            { "field" => { "$mod" => [ 10, 1 ]}}
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
            { "field" => { "$ne" => 10 }}
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
            { "field" => { "$near" => [ 1, 1 ] }}
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
            { "field" => { "$nearSphere" => [ 1, 1 ] }}
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
          selection.selector.should eq({ "field" => { "$nin" => [ 1, 2 ] }})
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $not" do

        let(:selection) do
          query.where(:field.not => /test/)
        end

        it "adds the $not criterion" do
          selection.selector.should eq({ "field" => { "$not" => /test/ }})
        end

        it "returns a cloned query" do
          selection.should_not eq(query)
        end
      end

      context "when performing a $size" do

        context "when providing an integer" do

          let(:selection) do
            query.where(:field.with_size => 10)
          end

          it "adds the $size criterion" do
            selection.selector.should eq(
              { "field" => { "$size" => 10 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not eq(query)
          end
        end

        context "when providing a string" do

          let(:selection) do
            query.where(:field.with_size => "10")
          end

          it "adds the $size criterion" do
            selection.selector.should eq(
              { "field" => { "$size" => 10 }}
            )
          end

          it "returns a cloned query" do
            selection.should_not eq(query)
          end
        end
      end

      context "when performing a $type" do

        let(:selection) do
          query.where(:field.with_type => 10)
        end

        it "adds the $type criterion" do
          selection.selector.should eq(
            { "field" => { "$type" => 10 }}
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
              { "field" => { "$within" => { "$center" => [[ 1, 1 ], 10 ]}}}
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
              { "field" => { "$within" => { "$box" => [[ 1, 1 ], [ 1, 1 ]]}}}
            )
          end

          it "returns a cloned query" do
            selection.should_not eq(query)
          end
        end
      end
    end
  end

  describe "#within_box" do

    context "when provided no criterion" do

      let(:selection) do
        query.within_box
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
        query.within_box(nil)
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
        query.within_box(location: [[ 1, 10 ], [ 10, 1 ]])
      end

      it "adds the $within expression" do
        selection.selector.should eq({
          "location" => { "$within" => { "$box" => [[ 1, 10 ], [ 10, 1 ]] }}
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.within_box(
            location: [[ 1, 10 ], [ 10, 1 ]],
            comments: [[ 1, 10 ], [ 10, 1 ]]
          )
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            "location" => { "$within" => { "$box" => [[ 1, 10 ], [ 10, 1 ]] }},
            "comments" => { "$within" => { "$box" => [[ 1, 10 ], [ 10, 1 ]] }}
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
            within_box(location: [[ 1, 10 ], [ 10, 1 ]]).
            within_box(comments: [[ 1, 10 ], [ 10, 1 ]])
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            "location" => { "$within" => { "$box" => [[ 1, 10 ], [ 10, 1 ]] }},
            "comments" => { "$within" => { "$box" => [[ 1, 10 ], [ 10, 1 ]] }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#within_circle" do

    context "when provided no criterion" do

      let(:selection) do
        query.within_circle
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
        query.within_circle(nil)
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
        query.within_circle(location: [[ 1, 10 ], 25 ])
      end

      it "adds the $within expression" do
        selection.selector.should eq({
          "location" => { "$within" => { "$center" => [[ 1, 10 ], 25 ] }}
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:selection) do
          query.within_circle(
            "location" => [[ 1, 10 ], 25 ],
            "comments" => [[ 1, 10 ], 25 ]
          )
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            "location" => { "$within" => { "$center" => [[ 1, 10 ], 25 ] }},
            "comments" => { "$within" => { "$center" => [[ 1, 10 ], 25 ] }}
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
            within_circle(location: [[ 1, 10 ], 25 ]).
            within_circle(comments: [[ 1, 10 ], 25 ])
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            "location" => { "$within" => { "$center" => [[ 1, 10 ], 25 ] }},
            "comments" => { "$within" => { "$center" => [[ 1, 10 ], 25 ] }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe "#within_polygon" do

    context "when provided no criterion" do

      let(:selection) do
        query.within_polygon
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
        query.within_polygon(nil)
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

      let(:polygon) do
        [[ 10, 20 ], [ 10, 40 ], [ 30, 40 ], [ 30, 20 ]]
      end

      let(:selection) do
        query.within_polygon(location: polygon)
      end

      it "adds the $within expression" do
        selection.selector.should eq({
          "location" => { "$within" => { "$polygon" => polygon }}
        })
      end

      it "returns a cloned query" do
        selection.should_not equal(query)
      end
    end

    context "when providing multiple criteria" do

      context "when the fields differ" do

        let(:polygon_one) do
          [[ 10, 20 ], [ 10, 40 ], [ 30, 40 ], [ 30, 20 ]]
        end

        let(:polygon_two) do
          [[ 10, 25 ], [ 10, 45 ], [ 30, 45 ], [ 30, 25 ]]
        end

        let(:selection) do
          query.within_polygon(
            location: polygon_one,
            comments: polygon_two
          )
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            "location" => { "$within" => { "$polygon" => polygon_one }},
            "comments" => { "$within" => { "$polygon" => polygon_two }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end

    context "when chaining multiple criteria" do

      context "when the fields differ" do

        let(:polygon_one) do
          [[ 10, 20 ], [ 10, 40 ], [ 30, 40 ], [ 30, 20 ]]
        end

        let(:polygon_two) do
          [[ 10, 25 ], [ 10, 45 ], [ 30, 45 ], [ 30, 25 ]]
        end

        let(:selection) do
          query.
            within_polygon(location: polygon_one).
            within_polygon(comments: polygon_two)
        end

        it "adds the $within expression" do
          selection.selector.should eq({
            "location" => { "$within" => { "$polygon" => polygon_one }},
            "comments" => { "$within" => { "$polygon" => polygon_two }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
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
          "location" => { "$within" => { "$centerSphere" => [[ 1, 10 ], 25 ] }}
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
            "location" => { "$within" => { "$centerSphere" => [[ 1, 10 ], 25 ] }},
            "comments" => { "$within" => { "$centerSphere" => [[ 1, 10 ], 25 ] }}
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
            "location" => { "$within" => { "$centerSphere" => [[ 1, 10 ], 25 ] }},
            "comments" => { "$within" => { "$centerSphere" => [[ 1, 10 ], 25 ] }}
          })
        end

        it "returns a cloned query" do
          selection.should_not equal(query)
        end
      end
    end
  end

  describe Symbol do

    describe "#all" do

      let(:key) do
        :field.all
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $all" do
        key.operator.should eq("$all")
      end
    end

    describe "#elem_match" do

      let(:key) do
        :field.elem_match
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $elemMatch" do
        key.operator.should eq("$elemMatch")
      end
    end

    describe "#exists" do

      let(:key) do
        :field.exists
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $exists" do
        key.operator.should eq("$exists")
      end
    end

    describe "#gt" do

      let(:key) do
        :field.gt
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $gt" do
        key.operator.should eq("$gt")
      end
    end

    describe "#gte" do

      let(:key) do
        :field.gte
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $gte" do
        key.operator.should eq("$gte")
      end
    end

    describe "#in" do

      let(:key) do
        :field.in
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $in" do
        key.operator.should eq("$in")
      end
    end

    describe "#lt" do

      let(:key) do
        :field.lt
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $lt" do
        key.operator.should eq("$lt")
      end
    end

    describe "#lte" do

      let(:key) do
        :field.lte
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $lte" do
        key.operator.should eq("$lte")
      end
    end

    describe "#mod" do

      let(:key) do
        :field.mod
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $mod" do
        key.operator.should eq("$mod")
      end
    end

    describe "#ne" do

      let(:key) do
        :field.ne
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $ne" do
        key.operator.should eq("$ne")
      end
    end

    describe "#near" do

      let(:key) do
        :field.near
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $near" do
        key.operator.should eq("$near")
      end
    end

    describe "#near_sphere" do

      let(:key) do
        :field.near_sphere
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $nearSphere" do
        key.operator.should eq("$nearSphere")
      end
    end

    describe "#nin" do

      let(:key) do
        :field.nin
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $nin" do
        key.operator.should eq("$nin")
      end
    end

    describe "#not" do

      let(:key) do
        :field.not
      end

      it "returns a selection key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $not" do
        key.operator.should eq("$not")
      end

    end

    describe "#with_size" do

      let(:key) do
        :field.with_size
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $size" do
        key.operator.should eq("$size")
      end
    end

    describe "#with_type" do

      let(:key) do
        :field.with_type
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $type" do
        key.operator.should eq("$type")
      end
    end

    describe "#within_box" do

      let(:key) do
        :field.within_box
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $within" do
        key.operator.should eq("$within")
      end

      it "sets the expanded operator as $box" do
        key.expanded.should eq("$box")
      end
    end

    describe "#within_circle" do

      let(:key) do
        :field.within_circle
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $within" do
        key.operator.should eq("$within")
      end

      it "sets the expanded operator as $center" do
        key.expanded.should eq("$center")
      end
    end

    describe "#within_polygon" do

      let(:key) do
        :field.within_polygon
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $within" do
        key.operator.should eq("$within")
      end

      it "sets the expanded operator as $polygon" do
        key.expanded.should eq("$polygon")
      end
    end

    describe "#within_spherical_circle" do

      let(:key) do
        :field.within_spherical_circle
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Key)
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

  context "when using multiple strategies on the same field" do

    context "when using the strategies via methods" do

      context "when the values are a hash" do

        let(:selection) do
          query.gt(field: 5).lt(field: 10).ne(field: 7)
        end

        it "merges the strategies on the same field" do
          selection.selector.should eq(
            { "field" => { "$gt" => 5, "$lt" => 10, "$ne" => 7 }}
          )
        end
      end

      context "when the values are not hashes" do

        let(:selection) do
          query.where(field: 5).where(field: 10)
        end

        it "overrides the previous field" do
          selection.selector.should eq({ "field" => 10 })
        end
      end
    end

    context "when using the strategies via #where" do

      context "when the values are a hash" do

        let(:selection) do
          query.where(:field.gt => 5, :field.lt => 10, :field.ne => 7)
        end

        it "merges the strategies on the same field" do
          selection.selector.should eq(
            { "field" => { "$gt" => 5, "$lt" => 10, "$ne" => 7 }}
          )
        end
      end
    end
  end
end
