# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $type selection.
    module Type

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def type(criterion = nil)
        __override__(criterion, "$type")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $type in a where query.
      #   queryable.where(:field.type => 15)
      #
      # @since 1.0.0
      ::Symbol.add_key(:type, "$type")
    end
  end
end
