# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Intersect

        def intersect
          tap { |query| query.strategy = :intersect! }
        end

        private

        def intersect!(criterion, operator)
          assimilate(criterion) do |selector, field, value|
            selector.intersect!(field, operator, value)
          end
        end
      end
    end
  end
end
