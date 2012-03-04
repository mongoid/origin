# encoding: utf-8
module Origin
  module Selectable

    # Contains behaviour for adding $and selection.
    module And

      # Add the $and criterion.
      #
      # @example Add the criterion.
      #   queryable.and({ field: value }, { other: value })
      #
      # @param [ Array<Hash> ] criterion Multiple key/value pair matches that
      #   all must match to return results.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def and(*criterion)
        __multi__(criterion, "$and")
      end
      alias :all_of :and
    end
  end
end
