# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $or selection.
    module Or

      # Adds $or selection to the queryable.
      #
      # @example Add the $or selection.
      #   queryable.or(field: 1, field: 2)
      #
      # @param [ Array ] criterion An array of hash criterion.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def or(*criterion)
        __multi__(criterion, "$or")
      end
      alias :any_of :or
    end
  end
end
