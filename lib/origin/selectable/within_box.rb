# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $within/$box selection.
    module WithinBox

      # Adds the $within/$box selection to the queryable.
      #
      # @example Add the selection.
      #   queryable.within_box(location: [[ 1, 10 ], [ 10, 1 ]])
      #
      # @example Execute an $within/$box in a where query.
      #   queryable.where(:field.within_box => [[ 1, 10 ], [ 10, 1 ]])
      #
      # @param [ Hash ] criterion The field/box corner criterion.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def within_box(criterion = nil)
        __expanded__(criterion, "$within", "$box")
      end

      ::Symbol.add_multi_key(:within_box, "$within", "$box")
    end
  end
end
