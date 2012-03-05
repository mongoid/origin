# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $nor selection.
    module Nor

      # Adds $nor selection to the queryable.
      #
      # @example Add the $nor selection.
      #   queryable.nor(field: 1, field: 2)
      #
      # @param [ Array ] criterion An array of hash criterion.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def nor(*criterion)
        __multi__(criterion, "$nor")
      end
    end
  end
end
