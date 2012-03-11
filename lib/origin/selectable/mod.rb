# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $mod selection.
    module Mod

      # Adds $mod selection to the queryable.
      #
      # @example Add the $mod selection.
      #   queryable.mod(field: [ 10, 1 ])
      #
      # @example Execute an $mod in a where query.
      #   queryable.where(:field.mod => [ 10, 1 ])
      #
      # @param [ Hash ] criterion The field/mod selections.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def mod(criterion = nil)
        __override__(criterion, "$mod")
      end

      ::Symbol.add_key(:mod, "$mod")
    end
  end
end
