require "spec_helper"

describe Origin::Options do

  describe "#__deep_copy__" do

    let(:sort) do
      [[ :name, :asc ]]
    end

    let(:options) do
      described_class.new
    end

    before do
      options[:sort] = sort
    end

    let(:cloned) do
      options.__deep_copy__
    end

    it "returns an equal copy" do
      cloned.should eq(options)
    end

    it "performs a deep copy" do
      cloned[:sort].should_not equal(sort)
    end
  end

  describe "#fields" do

    let(:options) do
      described_class.new
    end

    context "when field options exist" do

      before do
        options[:fields] = { name: 1 }
      end

      it "returns the field options" do
        options.fields.should eq({ "name" => 1 })
      end
    end

    context "when field options do not exist" do

      it "returns nil" do
        options.fields.should be_nil
      end
    end
  end

  describe "#limit" do

    let(:options) do
      described_class.new
    end

    context "when limit options exist" do

      before do
        options[:limit] = 20
      end

      it "returns the limit options" do
        options.limit.should eq(20)
      end
    end

    context "when limit options do not exist" do

      it "returns nil" do
        options.limit.should be_nil
      end
    end
  end

  describe "#skip" do

    let(:options) do
      described_class.new
    end

    context "when skip options exist" do

      before do
        options[:skip] = 100
      end

      it "returns the skip options" do
        options.skip.should eq(100)
      end
    end

    context "when skip options do not exist" do

      it "returns nil" do
        options.skip.should be_nil
      end
    end
  end

  describe "#sort" do

    let(:options) do
      described_class.new
    end

    context "when sort options exist" do

      before do
        options[:sort] = { name: 1 }
      end

      it "returns the sort options" do
        options.sort.should eq({ "name" => 1 })
      end
    end

    context "when sort options do not exist" do

      it "returns nil" do
        options.sort.should be_nil
      end
    end
  end

  [ :store, :[]= ].each do |method|

    describe "##{method}" do

      context "when aliases are provided" do

        context "when the alias has no serializer" do

          let(:options) do
            described_class.new({ "id" => "_id" })
          end

          before do
            options.send(method, :sort, { :id => 1 })
          end

          it "stores the field in the options by database name" do
            options[:sort].should eq({ "_id" => 1 })
          end
        end
      end

      context "when no serializers are provided" do

        let(:options) do
          described_class.new
        end

        context "when provided a standard object" do

          context "when the keys are strings" do

            it "does not serialize values" do
              options.send(method, "limit", "5").should eq("5")
            end
          end

          context "when the keys are symbols" do

            it "does not serialize values" do
              options.send(method, :limit, "5").should eq("5")
            end
          end
        end
      end

      context "when serializers are provided" do

        context "when the serializer is not localized" do

          before(:all) do
            class Field
              def localized?
                false
              end
            end
          end

          after(:all) do
            Object.send(:remove_const, :Field)
          end

          let(:options) do
            described_class.new({}, { "key" => Field.new })
          end

          context "when the criterion is simple" do

            before do
              options.send(method, :limit, 1)
            end

            it "does not localize the keys" do
              options[:limit].should eq(1)
            end
          end

          context "when the criterion is complex" do

            before do
              options.send(method, :sort, { :key => 1 })
            end

            it "does not localize the keys" do
              options[:sort].should eq({ "key" => 1 })
            end
          end
        end

        context "when the serializer is localized" do

          before(:all) do
            class Field
              def localized?
                true
              end
            end
          end

          after(:all) do
            Object.send(:remove_const, :Field)
          end

          let(:options) do
            described_class.new({}, { "key" => Field.new })
          end

          before do
            ::I18n.locale = :de
          end

          context "when the criterion is simple" do

            before do
              options.send(method, :limit, 1)
            end

            it "does not localize the keys" do
              options[:limit].should eq(1)
            end
          end

          context "when the criterion is complex" do

            before do
              options.send(method, :sort, { :key => 1 })
            end

            it "does not localize the keys" do
              options[:sort].should eq({ "key.de" => 1 })
            end
          end
        end
      end
    end
  end
end
