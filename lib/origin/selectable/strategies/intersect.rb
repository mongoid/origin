# encoding: utf-8
module Origin
  module Selectable
    module Strategies
      module Intersect

        def intersect
          tap { |query| query.strategy = :__intersect__ }
        end

        def __intersect__(criterion, operator)
          with_strategy(:__intersect__, criterion, operator)
        end
      end
    end
  end
end
