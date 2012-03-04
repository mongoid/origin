# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $within/$box selection.
    module WithinBox

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def within_box(criterion = nil)
        __expanded__(criterion, "$within", "$box")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $within/$box in a where query.
      #   queryable.where(:field.within_box => [[ 1, 10 ], [ 10, 1 ]])
      #
      # @since 1.0.0
      ::Symbol.add_multi_key(:within_box, "$within", "$box")
    end
  end
end
