# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $mod selection.
    module Mod

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def mod(criterion = nil)
        __override__(criterion, "$mod")
      end

      # Add the key to symbol for where matching.
      #
      # @example Execute an $mod in a where query.
      #   queryable.where(:field.mod => [ 10, 1 ])
      #
      # @since 1.0.0
      ::Symbol.add_key(:mod, "$mod")
    end
  end
end
