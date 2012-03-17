require "spec_helper"

describe Origin::Selectable::Exists do

  let(:query) do
    Origin::Query.new
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

  describe Symbol do

    describe "#exists" do

      let(:key) do
        :field.exists
      end

      it "returns a selecton key" do
        key.should be_a(Origin::Selectable::Key)
      end

      it "sets the name as the key" do
        key.name.should eq(:field)
      end

      it "sets the operator as $exists" do
        key.operator.should eq("$exists")
      end
    end
  end
end
