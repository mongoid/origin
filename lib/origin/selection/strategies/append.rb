# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Append

        private

        def append!(criterion, operator)
          assimilate(criterion) do |query, field, value|
            query.selector.append!(field, operator, value)
          end
        end
      end
    end
  end
end
