# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $type selection.
    module Type

      # Adds a $type selection to the queryable.
      #
      # @example Add the $type selection.
      #   queryable.type(field: 15)
      #
      # @example Execute an $type in a where query.
      #   queryable.where(:field.type => 15)
      #
      # @note http://vurl.me/PGOU contains a list of all types.
      #
      # @param [ Hash ] criterion The field/type pairs.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def type(criterion = nil)
        __override__(criterion, "$type")
      end

      ::Symbol.add_key(:type, "$type")
    end
  end
end
