# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $ne selection.
    module Ne

      # Adds $ne selection to the queryable.
      #
      # @example Query for a value $ne to something.
      #   queryable.ne(field: 10)
      #
      # @param [ Hash ] criterion The field/ne selections.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def ne(criterion = nil)
        __override__(criterion, "$ne")
      end
      alias :excludes :ne

      # Add the key to symbol for where matching.
      #
      # @example Execute an $ne in a where query.
      #   queryable.where(:field.ne => "value")
      #
      # @since 1.0.0
      ::Symbol.add_key(:ne, "$ne")
    end
  end
end
