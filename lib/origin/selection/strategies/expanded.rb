# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Expanded

        private

        def expanded!(criterion, outer, inner)
          assimilate(criterion) do |selector, field, value|
            selector.override!(field, outer, { inner => value })
          end
        end
      end
    end
  end
end
