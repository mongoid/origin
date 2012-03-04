# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $size selection.
    module Size

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def with_size(criterion = nil)
        __override__(criterion, "$size")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $size in a where query.
      #   queryable.where(:field.with_size => 10)
      #
      # @since 1.0.0
      ::Symbol.add_key(:with_size, "$size")
    end
  end
end
