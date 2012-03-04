# encoding: utf-8
module Origin
  module Selectable

    # Contains behaviour for adding a range selection between two values.
    module Between

      # Add the range selection.
      #
      # @example Match on results within a single range.
      #   queryable.between(field: 1..2)
      #
      # @example Match on results between multiple ranges.
      #   queryable.between(field: 1..2, other: 5..7)
      #
      # @param [ Hash ] criterion Multiple key/range pairs.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def between(criterion = nil)
        selection(criterion) do |selector, field, value|
          selector.store(
            field,
            { "$gte" => value.min, "$lte" => value.max }
          )
        end
      end
    end
  end
end
