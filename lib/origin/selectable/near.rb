# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $near selection.
    module Near

      # Adds a $near criterion to a geo selection.
      #
      # @example Add the $near selection.
      #   queryable.near(location: [ 23.1, 12.1 ])
      #
      # @example Execute an $near in a where query.
      #   queryable.where(:field.near => [ 23.2, 12.1 ])
      #
      # @param [ Hash ] criterion The field/location pair.
      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def near(criterion = nil)
        __override__(criterion, "$near")
      end

      ::Symbol.add_key(:near, "$near")
    end
  end
end
