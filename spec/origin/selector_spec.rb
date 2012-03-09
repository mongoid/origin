require "spec_helper"

describe Origin::Selector do

  describe "#__deep_copy__" do

    let(:value) do
      [ 1, 2, 3 ]
    end

    let(:selection) do
      { "$in" => value }
    end

    let(:selector) do
      described_class.new
    end

    before do
      selector[:field] = selection
    end

    let(:cloned) do
      selector.__deep_copy__
    end

    it "returns an equal copy" do
      cloned.should eq(selector)
    end

    it "performs a deep copy" do
      cloned["field"].should_not equal(selection)
    end

    it "clones n levels deep" do
      cloned["field"]["$in"].should_not equal(value)
    end
  end

  [ :store, :[]= ].each do |method|

    describe "##{method}" do

      context "when no serializers are provided" do

        let(:selector) do
          described_class.new
        end

        context "when provided a standard object" do

          context "when the keys are strings" do

            it "does not serialize values" do
              selector.send(method, "key", "5").should eq("5")
            end
          end

          context "when the keys are symbols" do

            it "does not serialize values" do
              selector.send(method, :key, "5").should eq("5")
            end
          end
        end

        context "when provided a range" do

          before do
            selector.send(method, "key", 1..3)
          end

          it "serializes the range" do
            selector["key"].should eq({ "$gte" => 1, "$lte" => 3 })
          end
        end

        context "when providing an array" do

          let(:big_one) do
            BigDecimal.new("1.2321")
          end

          let(:big_two) do
            BigDecimal.new("4.2222")
          end

          let(:array) do
            [ big_one, big_two ]
          end

          before do
            selector.send(method, "key", array)
          end

          it "serializes each element in the array" do
            selector["key"].should eq([ big_one.to_s, big_two.to_s ])
          end

          it "sets the same array instance" do
            selector["key"].should equal(array)
          end
        end
      end

      context "when serializers are provided" do

        context "when the serializer is not localized" do

          class Field
            def evolve(object)
              Integer.evolve(object)
            end

            def localized?
              false
            end
          end

          let(:selector) do
            described_class.new({ "key" => Field.new })
          end

          context "when the criterion is simple" do

            context "when the key is a string" do

              before do
                selector.send(method, "key", "5")
              end

              it "serializes the value" do
                selector["key"].should eq(5)
              end
            end

            context "when the key is a symbol" do

              before do
                selector.send(method, :key, "5")
              end

              it "serializes the value" do
                selector["key"].should eq(5)
              end
            end
          end

          context "when the criterion is complex" do

            context "when the field name is the key" do

              context "when the criterion is an array" do

                context "when the key is a string" do

                  before do
                    selector.send(method, "key", [ "1", "2" ])
                  end

                  it "serializes the value" do
                    selector["key"].should eq([ 1, 2 ])
                  end
                end

                context "when the key is a symbol" do

                  before do
                    selector.send(method, :key, [ "1", "2" ])
                  end

                  it "serializes the value" do
                    selector["key"].should eq([ 1, 2 ])
                  end
                end
              end

              context "when the criterion is a hash" do

                context "when the value is non enumerable" do

                  context "when the key is a string" do

                    before do
                      selector.send(method, "key", { "$gt" => "5" })
                    end

                    it "serializes the value" do
                      selector["key"].should eq({ "$gt" => 5 })
                    end
                  end

                  context "when the key is a symbol" do

                    before do
                      selector.send(method, :key, { "$gt" => "5" })
                    end

                    it "serializes the value" do
                      selector["key"].should eq({ "$gt" => 5 })
                    end
                  end
                end

                context "when the value is enumerable" do

                  context "when the key is a string" do

                    before do
                      selector.send(method, "key", { "$in" => [ "1", "2" ] })
                    end

                    it "serializes the value" do
                      selector["key"].should eq({ "$in" => [ 1, 2 ] })
                    end
                  end

                  context "when the key is a symbol" do

                    before do
                      selector.send(method, :key, { "$in" => [ "1", "2" ] })
                    end

                    it "serializes the value" do
                      selector["key"].should eq({ "$in" => [ 1, 2 ] })
                    end
                  end
                end

                [ "$and", "$or" ].each do |operator|

                  context "when the criterion is a #{operator}" do

                    context "when the individual criteria are simple" do

                      context "when the keys are strings" do

                        before do
                          selector.send(method, operator, [{ "key" => "1" }])
                        end

                        it "serializes the values" do
                          selector[operator].should eq([{ "key" => 1 }])
                        end
                      end

                      context "when the keys are symbols" do

                        before do
                          selector.send(method, operator, [{ key: "1" }])
                        end

                        it "serializes the values" do
                          selector[operator].should eq([{ "key" => 1 }])
                        end
                      end
                    end

                    context "when the individual criteria are complex" do

                      context "when the keys are strings" do

                        before do
                          selector.send(
                            method,
                            operator,
                            [{ "field" => "1" }, { "key" => { "$gt" => "2" }}]
                          )
                        end

                        it "serializes the values" do
                          selector[operator].should eq(
                            [{ "field" => "1" }, { "key" => { "$gt" => 2 }}]
                          )
                        end
                      end

                      context "when the keys are symbols" do

                        before do
                          selector.send(
                            method,
                            operator,
                            [{ field: "1" }, { key: { "$gt" => "2" }}]
                          )
                        end

                        it "serializes the values" do
                          selector[operator].should eq(
                            [{ "field" => "1" }, { "key" => { "$gt" => 2 }}]
                          )
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end

        context "when the serializer is localized" do

          class LocalizedField
            def evolve(object)
              Integer.evolve(object)
            end

            def localized?
              true
            end
          end

          let(:selector) do
            described_class.new({ "key" => LocalizedField.new })
          end

          before do
            ::I18n.locale = :de
          end

          context "when the criterion is simple" do

            context "when the key is a string" do

              before do
                selector.send(method, "key", "5")
              end

              it "serializes the value" do
                selector["key.de"].should eq(5)
              end
            end

            context "when the key is a symbol" do

              before do
                selector.send(method, :key, "5")
              end

              it "serializes the value" do
                selector["key.de"].should eq(5)
              end
            end
          end

          context "when the criterion is complex" do

            context "when the field name is the key" do

              context "when the criterion is an array" do

                context "when the key is a string" do

                  before do
                    selector.send(method, "key", [ "1", "2" ])
                  end

                  it "serializes the value" do
                    selector["key.de"].should eq([ 1, 2 ])
                  end
                end

                context "when the key is a symbol" do

                  before do
                    selector.send(method, :key, [ "1", "2" ])
                  end

                  it "serializes the value" do
                    selector["key.de"].should eq([ 1, 2 ])
                  end
                end
              end

              context "when the criterion is a hash" do

                context "when the value is non enumerable" do

                  context "when the key is a string" do

                    let(:hash) do
                      { "$gt" => "5" }
                    end

                    before do
                      selector.send(method, "key", hash)
                    end

                    it "serializes the value" do
                      selector["key.de"].should eq({ "$gt" => 5 })
                    end

                    it "sets the same hash instance" do
                      selector["key.de"].should equal(hash)
                    end
                  end

                  context "when the key is a symbol" do

                    before do
                      selector.send(method, :key, { "$gt" => "5" })
                    end

                    it "serializes the value" do
                      selector["key.de"].should eq({ "$gt" => 5 })
                    end
                  end
                end

                context "when the value is enumerable" do

                  context "when the key is a string" do

                    before do
                      selector.send(method, "key", { "$in" => [ "1", "2" ] })
                    end

                    it "serializes the value" do
                      selector["key.de"].should eq({ "$in" => [ 1, 2 ] })
                    end
                  end

                  context "when the key is a symbol" do

                    before do
                      selector.send(method, :key, { "$in" => [ "1", "2" ] })
                    end

                    it "serializes the value" do
                      selector["key.de"].should eq({ "$in" => [ 1, 2 ] })
                    end
                  end
                end

                [ "$and", "$or" ].each do |operator|

                  context "when the criterion is a #{operator}" do

                    context "when the individual criteria are simple" do

                      context "when the keys are strings" do

                        before do
                          selector.send(method, operator, [{ "key" => "1" }])
                        end

                        it "serializes the values" do
                          selector[operator].should eq([{ "key.de" => 1 }])
                        end
                      end

                      context "when the keys are symbols" do

                        before do
                          selector.send(method, operator, [{ key: "1" }])
                        end

                        it "serializes the values" do
                          selector[operator].should eq([{ "key.de" => 1 }])
                        end
                      end
                    end

                    context "when the individual criteria are complex" do

                      context "when the keys are strings" do

                        before do
                          selector.send(
                            method,
                            operator,
                            [{ "field" => "1" }, { "key" => { "$gt" => "2" }}]
                          )
                        end

                        it "serializes the values" do
                          selector[operator].should eq(
                            [{ "field" => "1" }, { "key.de" => { "$gt" => 2 }}]
                          )
                        end
                      end

                      context "when the keys are symbols" do

                        before do
                          selector.send(
                            method,
                            operator,
                            [{ field: "1" }, { key: { "$gt" => "2" }}]
                          )
                        end

                        it "serializes the values" do
                          selector[operator].should eq(
                            [{ "field" => "1" }, { "key.de" => { "$gt" => 2 }}]
                          )
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
