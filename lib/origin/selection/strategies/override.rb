# encoding: utf-8
module Origin
  module Selection
    module Strategies
      module Override

        def override
          tap { |query| query.strategy = :__override__ }
        end

        def __override__(criterion, operator)
          selection(criterion) do |selector, field, value|
            selector.store(field, { operator => value })
          end
        end
      end
    end
  end
end
