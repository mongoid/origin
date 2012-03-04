# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $lte selection.
    module Lte

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def lte(criterion = nil)
        __override__(criterion, "$lte")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $lte in a where query.
      #   queryable.where(:field.lte => 10)
      #
      # @since 1.0.0
      ::Symbol.add_key(:lte, "$lte")
    end
  end
end
