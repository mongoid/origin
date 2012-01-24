require "spec_helper"

describe Hash do

  describe "#_add" do

    context "when the other object is a non-enumerable" do

      pending "raises an error"
    end

    context "when the other object is an array" do

      pending "raises an error"
    end

    context "when the other object is a hash" do

      context "when a key matches" do

        context "when the existing value is a non-enumerable" do

          context "when the added value is non-enumerable" do

            context "when the values are unique" do

              let(:hash) do
                { "$in" => 5 }
              end

              before do
                hash._add({ "$in" => 6 })
              end

              it "sets the new array" do
                hash.should eq({ "$in" => [ 5, 6 ] })
              end
            end

            context "when the values are not unique" do

              let(:hash) do
                { "$in" => 5 }
              end

              before do
                hash._add({ "$in" => 5 })
              end

              it "keeps the old value" do
                hash.should eq({ "$in" => 5 })
              end
            end
          end
        end

        context "when the existing value is an array" do

          context "when the values are unique" do

            let(:hash) do
              { "$in" => [ 5, 6 ] }
            end

            before do
              hash._add({ "$in" => [ 7, 8 ] })
            end

            it "sets the new array" do
              hash.should eq({ "$in" => [ 5, 6, 7, 8 ] })
            end
          end

          context "when the values are not unique" do

            let(:hash) do
              { "$in" => [ 5, 6 ] }
            end

            before do
              hash._add({ "$in" => [ 6, 7 ] })
            end

            it "sets a new unique array" do
              hash.should eq({ "$in" => [ 5, 6, 7 ] })
            end
          end
        end
      end

      context "when a key does not match" do

        let(:hash) do
          { "$all" => [ 1, 2, 3 ] }
        end

        before do
          hash._add({ "$in" => [ 1, 2 ] })
        end

        it "merges in the new hash" do
          hash.should eq({
            "$all" => [ 1, 2, 3 ],
            "$in" => [ 1, 2 ]
          })
        end
      end
    end
  end

  describe "#_intersect" do

    context "when the other object is a non-enumerable" do

      pending "raises an error"
    end

    context "when the other object is an array" do

      pending "raises an error"
    end

    context "when the other object is a hash" do

      context "when a key matches" do

        context "when the existing value is a non-enumerable" do

          context "when the intersected value is non-enumerable" do

            context "when the values intersect" do

              let(:hash) do
                { "$in" => 5 }
              end

              before do
                hash._intersect({ "$in" => 5 })
              end

              it "sets the intersected array" do
                hash.should eq({ "$in" => [ 5 ] })
              end
            end

            context "when the values do not intersect" do

              let(:hash) do
                { "$in" => 5 }
              end

              before do
                hash._intersect({ "$in" => 6 })
              end

              it "sets the empty array" do
                hash.should eq({ "$in" => [] })
              end
            end
          end
        end

        context "when the existing value is an array" do

          context "when the values intersect" do

            let(:hash) do
              { "$in" => [ 5, 6 ] }
            end

            before do
              hash._intersect({ "$in" => [ 6, 7 ] })
            end

            it "sets the intersected array" do
              hash.should eq({ "$in" => [ 6 ] })
            end
          end

          context "when the values do not intersect" do

            let(:hash) do
              { "$in" => [ 5, 6 ] }
            end

            before do
              hash._intersect({ "$in" => [ 7, 8 ] })
            end

            it "sets the empty array" do
              hash.should eq({ "$in" => [] })
            end
          end
        end
      end

      context "when a key does not match" do

        let(:hash) do
          { "$all" => [ 1, 2, 3 ] }
        end

        before do
          hash._intersect({ "$in" => [ 1, 2 ] })
        end

        it "merges in the new hash" do
          hash.should eq({
            "$all" => [ 1, 2, 3 ],
            "$in" => [ 1, 2 ]
          })
        end
      end
    end
  end

  describe "#_union" do

    context "when the other object is a non-enumerable" do

      pending "raises an error"
    end

    context "when the other object is an array" do

      pending "raises an error"
    end

    context "when the other object is a hash" do

      context "when a key matches" do

        context "when the existing value is a non-enumerable" do

          context "when the unioned value is non-enumerable" do

            context "when the values are the same" do

              let(:hash) do
                { "$in" => 5 }
              end

              before do
                hash._union({ "$in" => 5 })
              end

              it "sets the unioned array" do
                hash.should eq({ "$in" => [ 5 ] })
              end
            end

            context "when the values are different" do

              let(:hash) do
                { "$in" => 5 }
              end

              before do
                hash._union({ "$in" => 6 })
              end

              it "sets the empty array" do
                hash.should eq({ "$in" => [ 5, 6 ] })
              end
            end
          end
        end

        context "when the existing value is an array" do

          let(:hash) do
            { "$in" => [ 5, 6 ] }
          end

          before do
            hash._union({ "$in" => [ 6, 7 ] })
          end

          it "sets the unioned array" do
            hash.should eq({ "$in" => [ 5, 6, 7 ] })
          end
        end
      end

      context "when a key does not match" do

        let(:hash) do
          { "$all" => [ 1, 2, 3 ] }
        end

        before do
          hash._union({ "$in" => [ 1, 2 ] })
        end

        it "merges in the new hash" do
          hash.should eq({
            "$all" => [ 1, 2, 3 ],
            "$in" => [ 1, 2 ]
          })
        end
      end
    end
  end
end
