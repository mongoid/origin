# encoding: utf-8
module Origin
  module Selectable

    # Provides behaviour for $in selection.
    module In

      #
      # @return [ Queryable ] The cloned queryable.
      #
      # @since 1.0.0
      def in(criterion = nil)
        send(strategy || :__intersect__, in_friendly(criterion), "$in")
      end
      alias :any_in :in

      # Add the key to symbol for where matching.
      #
      # @example Execute an $in in a where query.
      #   queryable.where(:field.in => [ 1, 2, 3 ])
      #
      # @since 1.0.0
      ::Symbol.add_key(:in, "$in")

      private

      # Convert the criterion values to $in friendly values. This means you,
      # array.
      #
      # @api private
      #
      # @example Convert all the values to arrays.
      #   queryable.make_in_friendly({ key: 1...4 })
      #
      # @param [ Hash ] criterion The criterion.
      #
      # @return [ Hash ] The $in friendly criterion.
      #
      # @since 1.0.0
      def in_friendly(criterion)
        return nil unless criterion
        criterion.each_pair do |key, value|
          criterion[key] = value.in_friendly
        end
      end
    end
  end
end
