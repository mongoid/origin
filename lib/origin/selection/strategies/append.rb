# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Append

        private

        def append!(criterion, operator)
          assimilate(criterion) do |selector, field, value|
            selector.append!(field, operator, value)
          end
        end
      end
    end
  end
end
